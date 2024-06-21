import { generateDartClasses } from "./Class";
import { generateClientExtension } from "./ClientExtension";
import { Definitions } from "./utils";

export const generateClassesAndClient = async (definitions: Definitions) => {
  const dartClasses = generateDartClasses(definitions);
  const clientExtension = generateClientExtension(definitions);
  return `${dartClasses}\n\n${clientExtension}`.trim();
};
