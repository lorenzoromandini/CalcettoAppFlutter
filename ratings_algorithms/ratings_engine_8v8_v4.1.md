# Player Rating Algorithm — Full Specification (v4.1)

## Overview

This system computes a deterministic rating for players in 8v8 high-scoring matches.

- Range: 3 to 10  
- Step: 0.25  

The model is continuous, role-aware, and context-aware.

---

## Inputs

Each player has:

- role ∈ {GK, DEF, MID, ST}  
- goals_open  
- goals_penalty  
- team_goals_for  
- team_goals_against  
- result ∈ {win, draw, loss}  
- penalties_missed  
- own_goals  
- penalties_saved  
- mention ∈ {-1, 0, 1}  

---

## Constants

BASE = 5.3  
MIN = 3  
MAX = 10  
ROUND_STEP = 0.25  

---

## Derived Variables

total_goals = team_goals_for + team_goals_against  
margin = team_goals_for - team_goals_against  
loss_margin = team_goals_against - team_goals_for  

penalty_weight = 1.0 if total_goals ≤ 6, else 0.8  

G_eff = goals_open + goals_penalty × penalty_weight  

goal_share = G_eff / team_goals_for (0 if team_goals_for = 0)  

error_decisive =  
- result = loss  
- loss_margin ≤ 2  
- at least one error  

closed_factor = clamp((8 − total_goals)/4, 0, 1)

---

## Weights

Result:
- win: +2.3  
- draw: 0  
- loss: −1.8  

Goal weights:
- ST: 1.0  
- MID: 1.08  
- DEF: 1.2  
- GK: 1.5  

Miss penalty:
- ST: −1.5  
- MID: −1.2  

---

## Components

### Goals

goal_component = role_weight × (goal_share^1.2) × 3.0  

---

### Miss Penalty

Applied if:
- team scored ≥ 5  
- player scored 0  
- role is ST or MID  

Scaled by team goals.

---

### Conceded Goals

Piecewise function:

- ≤5 → 0  
- 6–8 → linear increase  
- >8 → stronger increase  

Scaled by role.

---

### Clean / Near Clean

- 0 conceded → strong bonus (GK highest)  
- 1 conceded → +0.9  
- 2 conceded → +0.6  

---

### Closed Match Bonus

Scaled by closed_factor:

- GK highest  
- then DEF  
- then MID  
- then ST  

---

### Margin

Scaled by margin and role.

---

### Team Bonus

(team_goals_for − team_goals_against) / 10  

---

### Errors

- Missed penalties: −1.4 each  
- Own goals: −1.1 each  

Amplified if decisive.  
Reduced if player wins.

---

### Goalkeeper Bonuses

- +0.6 for win  
- +0.3 if conceded ≥ 6  
- +0.6 if conceded ≥ 9  

---

### Penalty Saves

+0.8 per save (GK only)

---

## Caps

### No Goal (Soft)

If player scores 0:

- ST ≤ 7.25  
- MID ≤ 7.5  

---

### Mention

- +0.5 (positive)  
- −0.5 (negative)  

Applied after soft cap.

---

### Team Scored 0 (Hard)

If team loses and scores 0:

- ST/MID ≤ 6.5  
- DEF/GK ≤ 7.0  

---

## Extreme Matches

If total goals ≥ 14:

Ratings above 8.5 are compressed.

---

## Normalization

Target average: 6.5  

Shift limited to ±0.5  

Reduced if margin ≥ 5  

---

## Numerical Stability

Quantization applied during computation.

---

## Final Steps

1. Clamp to [3, 10]  
2. Round to nearest 0.25  

---

## MVP Selection

1. Select highest rating  

Tie-breakers:

- Opposite teams → winner preferred  
- Same team → higher bonus-minus-malus  
- Draw → higher bonus-minus-malus  

Fallback: manual decision  

---

## Properties

- Deterministic  
- Continuous  
- Role-aware  
- Robust to edge cases  

---

## Status

This specification is complete and sufficient for exact implementation.
