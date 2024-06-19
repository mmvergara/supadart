import { Definitions } from "./utils";

export const exampleDefinitions: Definitions = {
  books: {
    required: ["id", "book_name", "created_at", "sold", "price"],
    properties: {
      id: {
        description: "Note:\nThis is a Primary Key.<pk/>",
        format: "bigint",
        type: "integer",
      },
      book_name: {
        format: "text",
        type: "string",
      },
      created_at: {
        default: "now()",
        format: "timestamp with time zone",
        type: "string",
      },
      book_description: {
        format: "text",
        type: "string",
      },
      sold: {
        default: false,
        format: "boolean",
        type: "boolean",
      },
      price: {
        format: "double precision",
        type: "number",
      },
    },
    type: "object",
  },
};
