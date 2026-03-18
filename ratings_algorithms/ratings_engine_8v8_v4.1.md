# Player Rating Algorithm — Natural Language Description

## Overview

This system evaluates player performance by combining individual actions, team context, match dynamics, and role expectations.

The rating is not a simple sum of events. Each contribution is interpreted relative to:
- how the match unfolded
- how difficult the scenario was
- what is expected from the player’s role

---

## Core Evaluation Logic

Each player starts from a neutral baseline. The rating is then adjusted through a set of interacting components.

### 1. Match Outcome Context

- Winning increases ratings.
- Losing decreases ratings.
- Draws are neutral.

However, this is modulated by context:
- Large victories amplify positive effects.
- Heavy losses amplify negative effects.
- Close matches make individual actions more impactful.

---

### 2. Offensive Contribution (Goals)

Goal evaluation depends on three dimensions:

#### a. Quantity and Type
- Open-play goals are more valuable than penalties in high-scoring matches.
- In low-scoring matches, penalties retain higher importance.

#### b. Share of Team Output
- Scoring a large portion of the team’s goals increases impact.
- Scoring in already high-scoring teams yields less relative benefit.

#### c. Role Expectations
- Attackers are expected to score → stricter evaluation.
- Midfielders receive moderate extra credit.
- Defenders and goalkeepers receive strong bonuses for scoring.

---

### 3. Failure to Score (Attacking Roles Only)

Applied only in specific scenarios:
- Team scores many goals
- Player scores none
- Player is attacker or midfielder

Effect:
- Considered underperformance
- Reduces rating proportionally to how many goals the team scored

Not applied in:
- Low-scoring matches
- Difficult or defensive games

---

### 4. Defensive Performance (Goals Conceded)

Goals conceded are evaluated non-linearly:

- Few goals conceded → little or no penalty
- Moderate goals conceded → increasing penalty
- Many goals conceded → strong penalty

Role impact:
- Stronger for goalkeepers and defenders
- Reduced for midfielders and attackers

Context adjustment:
- In very high-scoring matches, penalties are softened

---

### 5. Clean Sheet and Near-Clean Performance

Defensive success yields bonuses:

- No goals conceded → strong bonus (especially for GK)
- One or two goals conceded → moderate bonus

This rewards overall defensive solidity even if not perfect.

---

### 6. Match Type (Closed vs Open Games)

The system distinguishes between:

#### Closed Matches (low total goals)
- More tactical and difficult
- Defensive performance is highly rewarded
- Goalkeepers and defenders benefit most

#### Open Matches (high total goals)
- More chaotic
- Defensive contributions are less emphasized
- Offensive contributions are relatively less decisive per goal

---

### 7. Goal Difference and Team Performance

Two related effects:

#### a. Margin of Victory/Defeat
- Larger margins increase rating adjustments
- Strong wins → additional boost
- Heavy losses → additional penalty

#### b. Team Performance Component
- Players benefit when their team outscores the opponent
- Players are penalized when the opposite happens

This ensures alignment between individual ratings and team success.

---

### 8. Errors and Negative Events

Tracked explicitly:

- Missed penalties
- Own goals

Effects:
- Always reduce rating
- Stronger penalty if:
  - Match is close
  - Team loses
  - Error is decisive

Mitigation:
- If the team wins, penalties are partially reduced

---

## Role-Based Evaluation

### Goalkeeper (GK)

Key drivers:
- Goals conceded (primary responsibility)
- Clean sheet bonuses (highest among roles)
- Match difficulty (closed matches heavily rewarded)

Additional adjustments:
- Bonus for winning
- Compensation in high-concession matches (not all goals are attributable)
- Strong reward for penalty saves

---

### Defenders (DEF)

Key drivers:
- Defensive solidity (goals conceded)
- Clean/near-clean bonuses
- Performance in closed matches

Additional traits:
- Strong reward for scoring
- More tolerant than attackers for lack of goals

---

### Midfielders (MID)

Balanced evaluation:

- Offensive contribution (goals)
- Defensive context (partially considered)
- Match control (implicit via team performance)

Special rules:
- Penalized if team scores many goals and player scores none
- Moderate bonus for scoring compared to attackers

---

### Attackers (ST)

Primary focus:
- Goal scoring
- Share of team offensive output

Strict evaluation:
- Strong penalty if:
  - Team scores many goals
  - Player scores none

Less emphasis on:
- Defensive contribution
- Goals conceded

---

## Special Constraints and Caps

### 1. No-Goal Cap (Attackers and Midfielders)

If a player scores zero:
- Maximum rating is limited

Purpose:
- Prevent high ratings without fulfilling offensive role

---

### 2. Team Failed to Score (Loss Only)

If team:
- Scores zero
- Loses the match

Then:
- All players have a rating ceiling
- Stricter for attacking roles

---

### 3. Subjective Mentions

Optional adjustment:
- Positive mention → small increase
- Negative mention → small decrease

Applied after all other computations.

---

### 4. Extreme Matches (Very High Scoring)

If match is extremely high-scoring:
- Top ratings are compressed

Purpose:
- Prevent inflation due to chaotic conditions

---

## Normalization

After all adjustments:
- Ratings are shifted so the match average stays consistent
- Adjustment is limited to avoid distortion
- Reduced effect in very unbalanced matches

---

## Finalization

The final rating:
- Is bounded within a fixed range
- Is discretized into fixed steps

---

## MVP Selection

The best player is determined by:

1. Highest rating

Tie-breakers:
- Prefer players from the winning team
- Compare net positive vs negative contributions
- In draws, prioritize overall contribution balance

If still tied:
- Manual decision

---

## Summary

The system evaluates performance as a combination of:

- Individual contribution (goals, saves, errors)
- Team outcome and dominance
- Match difficulty and structure
- Role-specific expectations

Each rating emerges from the interaction of these factors rather than isolated statistics.
