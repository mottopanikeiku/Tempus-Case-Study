$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$requiredFiles = @(
  "docs/problem-framing.md",
  "docs/data-contract.md",
  "docs/scoring-rubric.md",
  "prompts/system.md",
  "prompts/objection-handler.md",
  "prompts/meeting-script.md",
  "evals/output-checklist.md",
  "ai/grounding_rules.md",
  "ai/priority_rationale_prompt.md",
  "ai/intro_script_prompt.md",
  "ai/week_plan_prompt.md"
)

$missing = @()
$empty = @()

foreach ($relativePath in $requiredFiles) {
  $fullPath = Join-Path $root $relativePath
  if (-not (Test-Path $fullPath)) {
    $missing += $relativePath
    continue
  }

  $content = (Get-Content $fullPath -Raw).Trim()
  if (-not $content) {
    $empty += $relativePath
  }
}

if ($missing.Count -gt 0) {
  Write-Error ("Missing AI asset files: " + ($missing -join ", "))
}

if ($empty.Count -gt 0) {
  Write-Error ("Empty AI asset files: " + ($empty -join ", "))
}

$tokenSummary = @{}
$foldersToScan = @("prompts", "evals", "ai")

foreach ($folder in $foldersToScan) {
  $fullFolder = Join-Path $root $folder
  if (-not (Test-Path $fullFolder)) {
    continue
  }

  Get-ChildItem $fullFolder -Filter "*.md" | ForEach-Object {
    $matches = [regex]::Matches((Get-Content $_.FullName -Raw), "\{\{([a-zA-Z0-9_]+)\}\}") |
      ForEach-Object { $_.Groups[1].Value } |
      Sort-Object -Unique
    $tokenSummary[$folder + "/" + $_.Name] = if ($matches) { $matches -join ", " } else { "-" }
  }
}

Write-Host "Prompt/eval asset check passed." -ForegroundColor Green
Write-Host ""
Write-Host "Required files:"
foreach ($relativePath in $requiredFiles) {
  Write-Host ("- " + $relativePath)
}

Write-Host ""
Write-Host "Template tokens:"
foreach ($fileName in $tokenSummary.Keys | Sort-Object) {
  Write-Host ("- " + $fileName + ": " + $tokenSummary[$fileName])
}
