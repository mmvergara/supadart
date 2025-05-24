# PostGIS Type Support
[PostGIS](https://postgis.net/) `geometry` and `geography` types are currently supported via the [geobase](https://geospatial.navibyte.dev/v1/geobase/) package. Both types are stored in hex-encoded [Well Known Binary](https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry#Well-known_binary) (WKB) format in Postgres. The WKB is read as a raw string from the db without using any of the PostGIS functions to decode it. The geobase package decodes the WKB to a Dart object to interface with the data. It encodes the data back to WKB when writing to the db.

## Getting Started
Add the `geobase` package to your app's `pubspec.yaml`:
```yaml
dependencies:
  geobase: ^1.5.0
```
Enable PostGIS support in your `supadart.yaml`:
```yaml
postGIS: true
```

## Example Usage
This is an example for a table named `test` with a `geography` column named `point`. Pattern matching is used to handle the different types of geometries the column may contain (Point, MultiPoint, Polygon, etc).
```Dart
import 'package:flutter/material.dart';
import 'package:geobase/geobase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '/models/generated_classes.dart';

class PostGISTypeDemo extends StatelessWidget {
  const PostGISTypeDemo({super.key});

  @override
  Widget build(context) => Scaffold(
    body: FutureBuilder(
      future: Supabase.instance.client.test.select().withConverter(
        Test.converter,
      ),
      builder:
          // Pattern matching switch for connection state
          (context, snapshot) => switch (snapshot.connectionState) {
            // Connection is loading
            ConnectionState.waiting => LinearProgressIndicator(),
            // Connection is done
            ConnectionState.done =>
              snapshot.hasError
                  ? ErrorPage()
                  : ListView.builder(
                    itemBuilder:
                        (context, index) => ListTile(
                          // Pattern matching switch for geometry type
                          title: switch (snapshot.data?[index].point) {
                            // Display coordinates for Point type
                            final Point p => Text(
                              '${p.position.x}, ${p.position.y}',
                            ),
                            // Display number of points in MultiPoint type
                            final MultiPoint mp => Text(
                              'Multipoint with ${mp.points.length} points',
                            ),
                            // Display centroid coordinates for Polygon type
                            final Polygon pg => Text('Polygon with centroid ${pg.centroid2D()!.x}, ${pg.centroid2D()!.y}'),
                            // Default
                            _ => Text('This type is unsupported!'),
                          },
                        ),
                    itemCount: snapshot.data?.length,
                  ),
            _ => Placeholder(),
          },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed:
          () async => await Supabase.instance.client.test.insert(
            Test.insert(point: Point([-85.90, 32.85].xy)),
          ),
    ),
  );
}
```