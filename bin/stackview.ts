#!/usr/bin/env -S deno run --allow-run=bat --allow-read

// For C# exceptions
const stackLineRegex = /^\s+at .* in (.*):line (\d+)/;

let foundException = false;
const exceptionLines = [];

// Read stdin line by line
const decoder = new TextDecoder();
for await (const chunk of Deno.stdin.readable) {
  const text = decoder.decode(chunk);
  for (const line of text.split("\n")) {
    const match = stackLineRegex.exec(line);
    if (!match) {
      if (
           !foundException
        && !/^\s+at /.test(line)
        && !/^\s*--- End of stack trace from previous location ---/.test(line)
        && !/^\s*$/.test(line)
      ) {
        exceptionLines.push(line);
      }
      continue;
    }
    if (!foundException) {
        foundException = true;
        console.log("\n\n");
        for (const line of exceptionLines) {
          console.log(line);
        }
        console.log("\n\n");
    }

    const filePath = match[1];
    const lineNumber = parseInt(match[2], 10);

    if (!filePath) continue;

    try {
      await Deno.stat(filePath);
    } catch {
      continue; // file doesn’t exist
    }

    console.log(`\n>>> ${filePath}:${lineNumber}\n`);

    // Run bat to show context
    const start = Math.max(1, lineNumber - 5);
    const end = lineNumber + 5;

    const bat = new Deno.Command("bat", {
      args: [
        "--paging=never",
        "--style=numbers,header",
        "--color=always",
        `--highlight-line=${lineNumber}`,
        `--line-range=${start}:${end}`,
        filePath,
      ],
      stdin: "null",
      stdout: "inherit",
      stderr: "inherit",
    });

    await bat.spawn().status;
  }
}

