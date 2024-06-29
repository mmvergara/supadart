import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({ subsets: ["latin"] });

export const metadata: Metadata = {
  title: "Supabase Schema to Dart Classes",
  description: "Generate Dart classes from your Supabase schema.",
  abstract: "Generate Dart classes from your Supabase schema.",
  keywords: [
    "Supabase",
    "Dart",
    "Schema",
    "Flutter",
    "Flutter SDK",
    "Flutter Dart",
    "Flutter Types",
    "Flutter Models",
    "Flutter Classes",
  ],

  applicationName: "Supabase Schema to Dart Classes | Supadart",
  appLinks: {
    web: {
      url: "https://supabase-schema-dart-class-generator.vercel.app/",
    },
  },
  archives: [
    "https://github.com/mmvergara/supabase-schema-dart-class-generator",
  ],
  authors: [
    {
      name: "mmvergara",
      url: "https://github.com/mmvergara",
    },
  ],
  openGraph: {
    type: "website",
    title: "Supabase Schema to Dart Classes",
    description:
      "Typesafe Supabase Flutter Queries, Generate Dart classes from your Supabase schema.",
    url: "https://supabase-schema-dart-class-generator.vercel.app/",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <meta
        name="google-site-verification"
        content="9L9yVl1B38S_ABkJE_s2iQbhCLNYOgPMi_C8kKrWFAg"
      />
      <body className={inter.className}>{children}</body>
    </html>
  );
}
