"use client";
import { useState } from "react";
import { generateDartModelSingleFile } from "@/generators";

const App = () => {
  const [supabaseUrl, setSupabaseUrl] = useState("");
  const [supabaseAnonKey, setSupabaseAnonKey] = useState("");
  const [isLoading, setIsLoading] = useState<boolean>(false);

  const [copyStatus, setCopyStatus] = useState("Copy to Clipboard");
  const [output, setOutput] = useState("Output");

  const handleGenerate = async () => {
    try {
      setIsLoading(true);
      const res = await fetch(
        `${supabaseUrl}/rest/v1/?apikey=${supabaseAnonKey}`
      );
      setIsLoading(false);
      if (!res.ok) {
        setOutput("Error fetching data");
        return;
      }

      const contentType = res.headers.get("content-type");
      if (
        !contentType ||
        contentType.indexOf("application/openapi+json") === -1
      ) {
        setOutput("Invalid Supabase URL or API key");
        return;
      }

      const data = await res.json();
      if (!data.definitions) {
        setOutput("No definitions found");
        return;
      }

      const outputCode = generateDartModelSingleFile(data.definitions, false);
      setOutput(outputCode);
    } catch (e) {
      console.log(e);
      setOutput("Error fetching data");
    }
  };

  const handleCopyToClipboard = () => {
    navigator.clipboard.writeText(output);

    setCopyStatus("Copied to Clipboard!");

    setTimeout(() => {
      setCopyStatus("Copy to Clipboard");
    }, 2000);
  };

  return (
    <div className="container">
      <h1
        style={{
          color: "#37996b",
          textAlign: "center",
          width: "100%",
        }}
      >
        Supabase Schema to Dart Classes
        <a
          href="https://github.com/mmvergara/supabase-schema-dart-class-generator"
          style={{
            color: "#4493d1",
            marginLeft: "10px",
          }}
          target="_blank"
        >
          Github
        </a>
      </h1>
      <p>This tool will generate Dart classes from your Supabase schema.</p>

      <h2>Generate via API</h2>

      <input
        id="SUPABASE_URL_INPUT"
        placeholder="SUPABASE_URL"
        onChange={(e) => {
          setSupabaseUrl(e.target.value);
        }}
        value={supabaseUrl}
      />
      <input
        id="SUPABASE_ANON_KEY_INPUT"
        placeholder="SUPABASE_ANON_KEY"
        onChange={(e) => {
          setSupabaseAnonKey(e.target.value);
        }}
        value={supabaseAnonKey}
      />
      <button onClick={handleGenerate} disabled={isLoading} id="generate">
        {isLoading ? "Generating..." : "Generate"}
      </button>
      <button onClick={handleCopyToClipboard} id="copy">
        {copyStatus}
      </button>
      <pre>
        <code id="code-output">{output}</code>
      </pre>
    </div>
  );
};

export default App;
