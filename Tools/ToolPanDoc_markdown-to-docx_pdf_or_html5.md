# Pandoc: markdown to docx, PDF or html5

Pandoc is a tool to transform Markdown files to docx (Word), PDF or html5 files.

It can be installed [here](https://pandoc.org/installing.html).

## Visual Studio

The VSC extension `vscode-pandoc` allows to use Pandoc in VSC.

## Mermaid diagrams

Pandoc doesn't support Mermaid diagrams in Markdown.

To transform .md files containing Mermaid diagrams, install [mermaid-filter](https://github.com/raghur/mermaid-filter).

```bash
npm install --global mermaid-filter
```

Use this filter when running Pandoc:

```bash
pandoc -t docx -F mermaid-filter -o topic.docx topic.md
```

On Windows, replace `mermaid-filter` by `mermaid-filter.cmd`.
