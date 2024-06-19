export type Definitions = Record<string, Definition>;
export type Definition = {
  required: string[];
  properties: {
    [key: string]: {
      type: Type;
      format?: Format;
      default?: string | number | boolean;
      description?: string;
    };
  };
  type: "object";
};
export type Type = "string" | "integer" | "boolean" | "number";
export type Format =
  | "uuid"
  | "bigint"
  | "timestamp with time zone"
  | "text"
  | "smallint"
  | "number"
  | "boolean"
  | "double precision";

export const getDartType = (type: Type) => {
  switch (type) {
    case "integer":
    case "number":
      return "int";

    case "string":
      return "String";
    case "boolean":
      return "bool";
  }
};
