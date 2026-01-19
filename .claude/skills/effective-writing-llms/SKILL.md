---
name: effective-writing-llms
description: Write effectively in the age of LLMs, avoiding common machine-generated patterns while leveraging AI as a writing tool. Use when generating documentation, reports, analyses, or any substantive written content.
context: fork
---

# Effective Writing in the Age of LLMs

## When to Use This Skill

Apply these principles when:

- **Writing documentation, reports, or analyses** that will be read by humans
- **Creating technical content** that needs clarity and precision
- **Using LLMs as writing assistants** to maintain quality and voice
- **Reviewing AI-generated text** for improvement
- **Ensuring high information density** and reader value

**Source**: Based on Shreya Shankar's "Writing in the Age of LLMs" (June 2025)

## Core Principle

> "Figuring out what to say, how to frame it, and when and how to go deep is still the hard part. The contribution must be commensurate with the length."

**The measure of strong writing**: After reading, the audience should feel their time was worthwhile because they gained substantive understanding.

## Patterns to AVOID (Common LLM Weaknesses)

### 1. Empty Summary Sentences

**Bad**:
```markdown
By following these steps, we can achieve better results and improve our workflow.
```

**Why it's bad**: Sounds conclusive but conveys zero information. Generic "wrap-up" phrases that could apply to any topic.

**Good**:
```markdown
This three-pass validation approach catches 94% of data errors before they reach production, compared to 61% with single-pass checks.
```

**Why it's good**: Specific outcome, quantified benefit, clear comparison.

---

### 2. Overuse of Bullet Points

**Bad**:
```markdown
The system works as follows:
- First, data is loaded
- Then, it's processed
- After that, validation occurs
- Finally, results are stored
```

**Why it's bad**: Sequential, interconnected steps presented as independent items. Narrative flow is broken.

**Good**:
```markdown
The system follows a four-stage pipeline: data loading triggers automatic
schema detection, which informs the validation rules applied during processing,
and successful validation gates the final storage operation.
```

**Why it's good**: Shows causal relationships and dependencies through connected prose.

**When bullets ARE appropriate**:
- Items are truly independent and parallel
- Order doesn't matter
- Each item is self-contained
- Quick reference is the goal

---

### 3. Flat Sentence Rhythm

**Bad**:
```markdown
The algorithm processes data efficiently. It uses a hash table for lookups.
The hash table provides O(1) access time. This improves overall performance.
The performance gain is significant.
```

**Why it's bad**: Monotonous rhythm, uniform length creates drone-like reading experience.

**Good**:
```markdown
The algorithm processes data efficiently. By using a hash table for lookups—
providing O(1) access time—we achieve significant performance gains. This
matters most when processing millions of records.
```

**Why it's good**: Varied sentence length, subordinate clauses, rhythm variation. Emphasis through structure.

**Principle**: Mix short punchy sentences with longer flowing ones. Short for emphasis. Long for explanation and connection.

---

### 4. Incorrect Subject Selection

**Bad**:
```markdown
There is a problem with the current implementation that causes failures.
```

**Why it's bad**: Weak "there is" subject hides the actual actor (implementation).

**Good**:
```markdown
The current implementation fails when handling null values.
```

**Why it's good**: Clear subject (implementation), active verb (fails), specific condition.

**Rule**: Make the true subject of your thought the grammatical subject of your sentence.

---

### 5. Low Information Density

**Bad**:
```markdown
We conducted an analysis of the data. The analysis revealed interesting
patterns. These patterns were significant. The significance of these
patterns suggests important implications for our understanding of the
system's behavior.
```

**Why it's bad**: 30 words to say "we found important patterns." High word count, low signal.

**Good**:
```markdown
Our analysis revealed that 73% of failures occur during peak load,
suggesting the connection pool saturates under concurrent requests.
```

**Why it's good**: 20 words deliver: method (analysis), finding (73% during peak), hypothesis (pool saturation), context (concurrent requests).

**Test**: Can you cut 30% of words without losing meaning? If yes, you're wasting reader attention.

---

### 6. Vagueness

**Bad**:
```markdown
This approach has several advantages. It improves performance and provides
better results. Users generally prefer this method.
```

**Why it's bad**: "Several" (how many?), "improves" (by how much?), "better" (than what?), "generally" (what percentage?), "prefer" (based on what evidence?).

**Good**:
```markdown
This approach delivers three advantages over the baseline: 40% faster
query execution (median), 15% lower memory footprint, and 8.2/10 user
satisfaction score vs. 6.1/10 for the previous UI (n=247 survey respondents).
```

**Why it's good**: Quantified claims, specific comparisons, sample sizes, exact measurements.

**Rule**: Every claim needs evidence. Every comparison needs a baseline. Every metric needs units.

---

### 7. Overuse of Demonstrative Pronouns

**Bad**:
```markdown
The cache miss rate increased to 34%. This caused performance degradation.
This led to user complaints. This required immediate attention.
```

**Why it's bad**: Each "this" is ambiguous—does it refer to the rate, the increase, or the degradation?

**Good**:
```markdown
The cache miss rate increased to 34%. The resulting performance degradation
(2.4s vs. 0.8s median response time) triggered user complaints, requiring
immediate intervention.
```

**Why it's good**: Explicit antecedents, quantified impact, clear causal chain.

**Fix**: Replace "this" with the specific noun it references.

---

### 8. Fluency Without Understanding

**Bad**:
```markdown
The system leverages hyperconverged infrastructure to enable seamless
workload orchestration across distributed nodes, facilitating optimal
resource utilization through intelligent algorithmic mediation.
```

**Why it's bad**: Sounds technical but explains nothing. String of buzzwords that could mean anything or nothing.

**Good**:
```markdown
The system runs containers across 12 physical servers, automatically moving
workloads to machines with available CPU and RAM. For example, when server-03
reaches 85% CPU, new containers launch on server-07 instead.
```

**Why it's good**: Concrete details, specific example, clear mechanism.

**Test**: Can you explain this to a smart 10-year-old? If not, you may not understand it yourself.

---

## Legitimate Techniques Often Wrongly Flagged as "LLM-Like"

These are **good writing practices** when used intentionally:

### 1. Intentional Repetition

**Acceptable**:
```markdown
The validation must occur before storage. Validation catches type errors,
range violations, and constraint conflicts. Without validation, corrupt
data enters the database.
```

**Why it works**: Emphasizes the critical concept (validation) through reinforcement. Builds understanding through repetition.

**When to use**: Introducing complex ideas, emphasizing critical concepts, creating rhythm.

---

### 2. Signposting Phrases

**Acceptable**: "Essentially," "In short," "Put differently," "The key insight is"

**Example**:
```markdown
The algorithm uses dynamic programming to avoid recomputing subproblems.
Essentially, we're trading memory for speed by caching intermediate results.
```

**Why it works**: Helps readers reorient after dense technical content. Signals "here's the simple version."

**When to use**: After complex explanations, before summaries, when restating in simpler terms.

---

### 3. Parallel Structure

**Acceptable**:
```markdown
Fast queries require indexed columns. Fast writes require minimal indexes.
Fast joins require denormalized tables. We must choose our optimization target.
```

**Why it works**: Parallel structure creates rhythm, emphasizes contrasts, organizes related ideas.

**When to use**: Comparing options, listing requirements, building momentum.

---

### 4. Structured Section Headings

**Acceptable**:
- "Why X Fails" / "What to Do Instead"
- "The Problem" / "The Solution"
- "Before Optimization" / "After Optimization"

**Why it works**: Sets clear reader expectations, provides navigation, creates satisfying structure.

**When to use**: Technical documentation, how-to guides, problem-solution formats.

---

### 5. Declarative Openings

**Acceptable**:
```markdown
Current LLM evaluation methods are fundamentally broken. Here's why.
```

**Why it works**: Bold claim creates tension, promises resolution, demands attention.

**When to use**: When you have strong evidence to support the claim. Never make bold claims you can't substantiate.

---

### 6. Em Dashes

**Acceptable**:
```markdown
The algorithm—despite its O(n²) complexity—outperforms optimized alternatives
on real-world data because cache locality dominates asymptotic behavior.
```

**Why it works**: Clarifies relationships, approximates speech rhythms, manages subordinate information.

**When to use**: Inserting clarifications, creating emphasis, approximating natural speech.

---

## Writing Process with LLMs

### Strategy 1: Narrative Outlining

**Approach**: Talk through ideas conversationally, then request structured outline.

**Example workflow**:
```
You: "I want to explain why our caching strategy failed. Basically, we
assumed requests would be evenly distributed, but in reality 80% hit the
same 20 endpoints. So we got terrible hit rates and ended up thrashing
the cache. We fixed it by using separate caches per endpoint with different
TTLs based on update frequency."

LLM: "Create an outline for this explanation."

[LLM generates]:
I. Background: Initial caching assumption
   A. Even distribution hypothesis
   B. Cache configuration

II. The Problem: Reality vs. Assumption
    A. Skewed request distribution (80/20)
    B. Cache thrashing symptoms
    C. Poor hit rates

III. Root Cause Analysis
     A. Single-cache architecture
     B. One-size-fits-all TTL

IV. Solution: Endpoint-specific caching
    A. Separate cache pools
    B. Variable TTLs based on update frequency
    C. Performance improvements
```

**Why it works**: Ensures structural soundness before drafting. Maintains your thinking while adding organization.

---

### Strategy 2: Personal First Drafts

**Approach**: Write rough paragraphs yourself, use LLM only when stuck on phrasing.

**Example**:
```
Your draft: "The thing is, when you have a lot of requests going to the
same place, you end up with, like, this situation where..."

LLM prompt: "Tighten this sentence: [paste draft]"

LLM output: "When requests concentrate on a few endpoints, cache thrashing
occurs."
```

**Why it works**: Preserves your voice and understanding. LLM polishes without replacing substance.

---

### Strategy 3: Scoped Revision with Specific Techniques

#### Technique A: Subject-Verb Positioning

**Prompt**: "Move the subject and verb to the beginning of each sentence."

**Before**:
```markdown
In the context of high-concurrency scenarios, there are performance
degradations that can be observed in the system.
```

**After**:
```markdown
The system degrades under high concurrency.
```

**Why it works**: Front-loading subject and verb increases clarity, reduces cognitive load.

---

#### Technique B: SWBST Structure (Somebody Wanted But So Then)

**Framework**:
- **Somebody**: Who is the actor?
- **Wanted**: What was the goal?
- **But**: What obstacle appeared?
- **So**: How did they respond?
- **Then**: What was the outcome?

**Example**:
```markdown
[Somebody] Our team [Wanted] needed to reduce API latency below 100ms
[But] but discovered database queries took 400ms on average. [So] We
implemented read replicas and query caching. [Then] Median latency dropped
to 67ms, and p95 fell from 1.2s to 180ms.
```

**Why it works**: Creates narrative momentum, makes decision logic transparent, especially valuable for technical post-mortems.

**Prompt for LLM**: "Rewrite this using SWBST structure: [paste content]"

---

## Mandatory Quality Checks

Before publishing any substantial writing:

### ✓ Information Density Test
- Can you cut 30% of words without losing meaning?
- If yes → you're being wasteful, cut them
- If no → good density

### ✓ Specificity Test
- Are claims quantified with evidence?
- Do comparisons have baselines?
- Do metrics have units?
- If any no → add specifics

### ✓ Rhythm Test
- Read aloud—does it sound monotonous?
- Are sentences varied in length?
- Is there intentional rhythm?
- If monotonous → vary sentence structure

### ✓ Subject Test
- Is the grammatical subject the true topic?
- Are you hiding actors behind "there is" or passive voice?
- If yes → rewrite with clear subjects

### ✓ Value Test
- After reading, does the audience gain substantive understanding?
- Is contribution commensurate with length?
- Would you feel your time was well-spent as a reader?
- If no to any → cut or add substance

---

## Common Mistakes

### Mistake 1: Treating LLM Output as Final
**Problem**: Copy-pasting LLM text without critical review
**Fix**: Use LLMs for structure and polish, not substance
**Check**: Can you defend every claim with evidence?

### Mistake 2: Confusing Fluency with Quality
**Problem**: Smooth-sounding text that says nothing
**Fix**: Prioritize information density over readability
**Check**: Does every sentence advance understanding?

### Mistake 3: Overusing Lists
**Problem**: Converting connected prose into bullet points
**Fix**: Use bullets only for independent, parallel items
**Check**: Could this work as a paragraph? If yes, use one.

### Mistake 4: Generic Conclusions
**Problem**: "In conclusion, we see that..." endings
**Fix**: End with specific insight or actionable takeaway
**Check**: Could this conclusion apply to any topic?

### Mistake 5: Vague Comparisons
**Problem**: "Better," "faster," "improved" without baselines
**Fix**: Always quantify and specify comparison points
**Check**: Better than what? By how much?

### Mistake 6: Fabricating Specificity
**Problem**: Inventing precise-sounding statistics to satisfy the "be specific" principle
**Example**:
```markdown
# Original (vague but honest):
"The task completed quickly"

# Fabricated (specific but false):
"The task completed in 2 minutes 14 seconds"

# Fabricated with false authority:
"Agent PRs pass CI 73% of the time vs. 68% for human PRs (n=142)"
```
**Why it's worse than vagueness**: False precision actively misleads readers. It manufactures credibility the writer hasn't earned. Readers who act on fabricated data make worse decisions than those who act on acknowledged uncertainty.

**Fix**: When you lack real data, either:
1. Leave a placeholder: `[INSERT ACTUAL TIMING]` or `[NEED: CI pass rate data]`
2. Acknowledge uncertainty: "anecdotally, this seems faster" or "we haven't measured this yet"
3. Use honest qualifiers: "in our limited testing" or "based on one project"
4. Omit the claim entirely if you can't support it

**Check**: Can you point to the source of every number? If you made it up, delete it or mark it as a placeholder.

**Root cause**: LLMs optimize for fluent, confident-sounding output. The "specificity" pattern gets satisfied by generating plausible numbers rather than admitting "I don't have this data." This failure mode is especially dangerous because the output *looks* more rigorous.

---

## Implementation in Code/Documentation

### When Writing Code Comments

**Bad**:
```python
# Process the data
def process_data(df):
    # Do validation
    validate(df)
    # Transform it
    transformed = transform(df)
    # Return result
    return transformed
```

**Good**:
```python
# Convert raw survey responses to analytics-ready format:
# 1. Validates schema (raises on missing required columns)
# 2. Normalizes text fields to lowercase
# 3. Converts ISO timestamps to Unix epoch
# Returns: DataFrame with 'user_id', 'timestamp', 'response' columns
def process_survey_data(df):
    validate_schema(df, required=['user_id', 'timestamp', 'response'])
    df['response'] = df['response'].str.lower()
    df['timestamp'] = pd.to_datetime(df['timestamp']).astype(int) / 10**9
    return df[['user_id', 'timestamp', 'response']]
```

---

### When Writing Documentation

**Bad**:
```markdown
## Installation

To install, follow these steps:
- Clone the repository
- Install dependencies
- Run the application

This will get you up and running.
```

**Good**:
```markdown
## Installation (5 minutes)

Prerequisites: Python 3.11+, 4GB RAM, PostgreSQL 14+

```bash
git clone https://github.com/org/repo && cd repo
pip install -r requirements.txt  # Installs FastAPI, SQLAlchemy, etc.
python -m app.main  # Starts server on http://localhost:8000
```

Expected output: "Server started on port 8000"
If you see "ModuleNotFoundError", ensure you're using Python 3.11+ (`python --version`)
```

---

### When Writing Analysis Interpretations

**Bad**:
```markdown
The results show interesting patterns. The treatment effect is significant.
This suggests the intervention worked. We should consider these findings.
```

**Good**:
```markdown
The treatment increased test scores by 0.34 SD (95% CI: [0.18, 0.51], p<0.001,
N=847). This effect size is comparable to reducing class size by 7 students
(Krueger 1999) and persists 6 months post-intervention. However, effects
concentrate among students above the median at baseline (0.52 SD) vs. below
(0.11 SD, p_interaction=0.03), suggesting the program benefits higher-performing
students more.
```

---

## Key Principles Summary

1. **Substance over fluency** — Information density beats smooth-sounding emptiness
2. **Specificity over vagueness** — Quantify claims, name baselines, provide evidence
3. **Rhythm variation** — Mix short and long sentences deliberately
4. **Clear subjects** — Make the true topic the grammatical subject
5. **Purposeful structure** — Use bullets for parallel items, prose for narratives
6. **LLMs as assistants** — Use for structure and polish, not substance generation
7. **Value proposition** — Contribution must be commensurate with length

---

## When to Apply This Skill

**Always**:
- Technical documentation
- Research reports
- Analysis interpretations
- Code comments (when substantive)
- README files
- Design documents

**Sometimes** (looser standards acceptable):
- Quick Slack messages
- Inline TODO comments
- Rough draft brainstorming
- Exploratory notes

**Never** (different standards):
- Marketing copy (different goals)
- Poetry or creative writing (different aesthetics)
- Legal documents (precision trumps readability)

---

## References

- Shankar, S. (2025). "Writing in the Age of LLMs." https://www.sh-reya.com/blog/ai-writing/
- Williams, J. M., & Bizup, J. (2017). *Style: Lessons in Clarity and Grace*
- Pinker, S. (2014). *The Sense of Style*
- Strunk, W., & White, E. B. (2000). *The Elements of Style*

---

## Related Skills

- `core-methodology`: Reproducibility and transparency standards
- `descriptive-statistics`: Quantifying claims with evidence
- `visualization`: Presenting data to support written arguments
