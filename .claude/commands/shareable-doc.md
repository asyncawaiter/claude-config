# Generate Shareable Document

Generate a high-density, professional HTML document for PDF export.

## Design Principles

1. **High density** - Minimal padding/margins, compact layout
2. **Three colors only** - Black (#1a1a1a), gray (#666), and teal (#0f766e) with white/light gray backgrounds
3. **No emojis** - Use text only
4. **No metadata headers** - Title and subtitle only, no version/date/author blocks
5. **Robust flowcharts** - CSS-based arrows and lines, not Unicode characters

## CSS Foundation

```css
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    font-size: 11px;
    line-height: 1.4;
    color: #1a1a1a;
    background: #fff;
    padding: 20px 30px;
    max-width: 1000px;
    margin: 0 auto;
}

@media print {
    body { padding: 10px 15px; font-size: 10px; }
    .page-break { page-break-before: always; }
    * { -webkit-print-color-adjust: exact !important; print-color-adjust: exact !important; }
}

h1 { font-size: 20px; font-weight: 700; margin-bottom: 4px; }
h2 { font-size: 14px; font-weight: 700; margin: 20px 0 8px 0; padding-bottom: 4px; border-bottom: 1px solid #ccc; }
h3 { font-size: 12px; font-weight: 600; margin: 12px 0 6px 0; }
h4 { font-size: 11px; font-weight: 600; margin: 10px 0 4px 0; color: #666; }
p { margin-bottom: 6px; }

.subtitle {
    font-size: 13px;
    color: #666;
    margin-bottom: 16px;
    padding-bottom: 8px;
    border-bottom: 2px solid #1a1a1a;
}

table { width: 100%; border-collapse: collapse; margin: 8px 0; font-size: 10px; }
th, td { padding: 4px 8px; text-align: left; border: 1px solid #ccc; }
th { background: #f5f5f5; font-weight: 600; }

code { background: #f5f5f5; padding: 1px 4px; border-radius: 2px; font-family: monospace; font-size: 9px; }
pre { background: #1a1a1a; color: #e0e0e0; padding: 8px 12px; border-radius: 4px; margin: 8px 0; font-size: 9px; }

.summary-box { background: #0f766e; color: #fff; padding: 12px 16px; margin: 12px 0; }
.summary-box p { margin-bottom: 4px; }

.stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(100px, 1fr)); gap: 8px; margin: 12px 0; }
.stat-card { background: #f5f5f5; padding: 8px; text-align: center; }
.stat-value { font-size: 16px; font-weight: 700; color: #0f766e; }
.stat-label { font-size: 9px; color: #666; margin-top: 2px; }

.info-box { background: #f5f5f5; border-left: 3px solid #0f766e; padding: 6px 10px; margin: 8px 0; font-size: 10px; }
.formula-box { background: #f5f5f5; padding: 8px 12px; margin: 8px 0; font-size: 10px; }
.formula { font-family: Georgia, serif; font-size: 12px; font-style: italic; }

.two-col { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
ul, ol { margin: 6px 0 6px 20px; font-size: 10px; }
li { margin-bottom: 2px; }

.check { color: #0f766e; font-weight: 600; }

footer { margin-top: 20px; padding-top: 8px; border-top: 1px solid #ccc; text-align: center; font-size: 9px; color: #666; }
```

## Flowchart CSS (Robust)

Use CSS borders for arrows - never Unicode characters.

```css
.flowchart { margin: 12px 0; padding: 12px; background: #f5f5f5; }
.flow-row { display: flex; justify-content: center; align-items: center; gap: 12px; }
.flow-box { background: #fff; border: 1px solid #1a1a1a; padding: 6px 12px; text-align: center; min-width: 120px; font-size: 10px; }
.flow-box .title { font-weight: 600; }
.flow-box .count { font-size: 9px; color: #666; }
.flow-box.dark { background: #1a1a1a; color: #fff; }
.flow-box.dark .count { color: #aaa; }
.flow-box.accent { background: #0f766e; color: #fff; border-color: #0f766e; }
.flow-box.accent .count { color: #ccfbf1; }

.flow-connector { display: flex; flex-direction: column; align-items: center; padding: 4px 0; }
.flow-line { width: 1px; height: 12px; background: #1a1a1a; }
.flow-arrow { width: 0; height: 0; border-left: 4px solid transparent; border-right: 4px solid transparent; border-top: 6px solid #1a1a1a; }
.flow-label { font-size: 8px; color: #666; margin: 2px 0; }

.flow-horizontal { display: flex; align-items: center; }
.flow-h-line { height: 1px; width: 20px; background: #1a1a1a; }
.flow-h-arrow-left { width: 0; height: 0; border-top: 4px solid transparent; border-bottom: 4px solid transparent; border-right: 6px solid #1a1a1a; }
.flow-h-arrow-right { width: 0; height: 0; border-top: 4px solid transparent; border-bottom: 4px solid transparent; border-left: 6px solid #1a1a1a; }
```

## Flowchart HTML Pattern

```html
<div class="flowchart">
    <div class="flow-row">
        <div class="flow-box dark">
            <div class="title">Step 1</div>
            <div class="count">details</div>
        </div>
    </div>
    <div class="flow-connector">
        <div class="flow-line"></div>
        <div class="flow-arrow"></div>
        <div class="flow-label">label</div>
    </div>
    <div class="flow-row">
        <div class="flow-box">
            <div class="title">Step 2a</div>
        </div>
        <div class="flow-horizontal">
            <div class="flow-h-arrow-left"></div>
            <div class="flow-h-line"></div>
        </div>
        <div class="flow-box accent">
            <div class="title">Step 2b (highlighted)</div>
        </div>
    </div>
</div>
```

## Document Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>[Title]</title>
    <style>/* CSS above */</style>
</head>
<body>

<h1>[Title]</h1>
<div class="subtitle">[Subtitle] | [Date] | [Status]</div>

<div class="summary-box">
    <p><strong>Summary:</strong> [One sentence summary]</p>
    <p><strong>Purpose:</strong> [Why this matters]</p>
</div>

<!-- Stats grid for key metrics -->
<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-value">123</div>
        <div class="stat-label">Label</div>
    </div>
</div>

<!-- Sections with h2 -->
<h2>Section Title</h2>
<p>Content...</p>

<!-- Tables for data -->
<table>
    <tr><th>Header</th><th>Header</th></tr>
    <tr><td>Data</td><td>Data</td></tr>
</table>

<!-- Two column layout -->
<div class="two-col">
    <div>Left content</div>
    <div>Right content</div>
</div>

<!-- Callout boxes -->
<div class="info-box">
    <strong>Note:</strong> Important information
</div>

<div class="formula-box">
    <span class="formula">Formula here</span>
</div>

<!-- Status checks use blue -->
<p><span class="check">[OK]</span> Item passed validation</p>

<footer>[Document name] | [Date]</footer>

</body>
</html>
```

## Checklist Before Saving

- [ ] Print styles include `print-color-adjust: exact` for backgrounds to show in PDF
- [ ] No emojis anywhere
- [ ] Only #1a1a1a (black), #666 (gray), and #0f766e (teal) for text/accents
- [ ] Only #f5f5f5 (light gray) and #fff (white) for backgrounds (except summary-box uses teal)
- [ ] Teal used for: stat values, summary box background, info-box border, status checks, accent flow boxes
- [ ] Font sizes: 9-11px for body, 12-14px for headings, 16-20px for stat values
- [ ] Padding: 4-12px max
- [ ] Margins: 4-20px max
- [ ] Flowcharts use CSS borders for arrows, not Unicode
- [ ] Tables have compact padding (4px 8px)
- [ ] No metadata blocks at top (just title + subtitle line)

## Output

Save as `[TOPIC]_REPORT.html` in project root.

Tell user: "Open in browser, then Cmd+P > Save as PDF"
