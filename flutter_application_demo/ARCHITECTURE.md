# System Architecture & Design

## 1. System Architecture

### Frontend: Flutter (Mobile)
- **Architecture Pattern**: Feature-First Clean Architecture (Presentation, Domain, Data layers per feature).
- **State Management**: **Riverpod** (More robust and testable than Provider).
- **Navigation**: **GoRouter** (Declarative routing).
- **Styling**: Material 3 with custom Theme Extensions.

### Backend: Hybrid Approach
**Recommendation**: **Supabase** (PostgreSQL) + **Python (FastAPI)** Microservice (Future)
- **Primary Backend (Supabase)**:
    - **Authentication**: Handles user sign-up/login.
    - **Database (PostgreSQL)**: Ideal for relational data like "Daily Logs", "Expenses", and "nutritional info". SQL is superior for aggregating data for charts (e.g., "Sum of expenses per month").
    - **Storage**: For profile pictures or food images.
- **AI/Logic Layer**:
    - **Initial**: Supabase Edge Functions (TypeScript) or Client-side logic for Rule-based AI.
    - **Future**: Python (FastAPI) service hosting LLM/ML models, communicating via REST/gRPC.

### Rationale
- **Why Supabase over Firebase?**: The app relies heavily on **structured data** (macros, calories, budget) and **aggregations** (stats, charts). SQL (Postgres) performs these queries much more efficiently than NoSQL (Firestore).
- **Scalability**: Decoupling the AI logic allows independent scaling of the heavy compute parts.

---

## 2. Flutter Project Structure

```
lib/
├── main.dart
├── app.dart                  # App configuration, Theme, Router
├── core/                     # Shared kernel
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── widgets/              # Generic widgets (Buttons, Inputs)
├── features/
│   ├── auth/                 # Authentication Feature
│   ├── dashboard/            # Home/Dashboard
│   ├── workout/              # Workout Plans & Tracking
│   ├── nutrition/            # Food & AI Diet Plans
│   ├── expense/              # Budget & Expense Tracking
│   └── profile/              # User Settings & Goals
└── shared/
    ├── data/                 # Shared coding/models? (Or keep in features)
    ├── domain/
    └── providers/            # Global providers (User state, etc)
```

Each Feature folder (e.g., `nutrition`) follows:
```
nutrition/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   └── repositories/ (Abstract)
└── presentation/
    ├── providers/
    ├── screens/
    └── widgets/
```

---

## 3. Data Models

### UserWithGoal
- `id`: String
- `age`, `height`, `weight`: double
- `goal`: Enum (lose, gain, maintain)
- `activityLevel`: Enum (sedentary, active, etc.)
- `dietPreference`: Enum (veg, non_veg)
- `budgetLimit`: double

### DailyPlan (AI Generated)
- `id`: String
- `userId`: String
- `date`: DateTime
- `targetCalories`: int
- `targetProtein`: int
- `targetCarbs`: int
- `targetFat`: int
- `estimatedCost`: double

### Meal
- `id`: String
- `name`: String
- `calories`: int
- `protein`, `carbs`, `fat`: int
- `price`: double
- `type`: Enum (breakfast, lunch, dinner, snack)

### WorkoutSession
- `id`: String
- `date`: DateTime
- `exercises`: List<Exercise>
- `caloriesBurned`: int
- `durationMinutes`: int

---

## 4. AI Recommendation Logic (Rule-Based v1)

**Inputs**: BMR (Basal Metabolic Rate) Calculation via Harris-Benedict Equation.

**Logic Flow**:
1.  **Calculate BMR**:
    - Men: `88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)`
    - Women: `447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)`
2.  **Adjust for Activity**:
    - ` Sedentary: BMR * 1.2`
    - ` Active: BMR * 1.55`
3.  **Adjust for Goal**:
    - `Weight Loss: -500 kcal`
    - `Weight Gain: +500 kcal`
4.  **Macro Split (Standard)**:
    - Protein: 2g per kg of body weight (for muscle retention/building).
    - Fat: 0.8g per kg.
    - Carbs: Remaining calories.
5.  **Budget Constraint**:
    - If `dailyBudget < X`, prioritize high ROI protein sources (eggs, chicken breast, lentils) over premium ones (salmon, steak).

---

## 5. API / Data Flow

1.  **App Start**: Fetch `UserWithGoal`.
2.  **Daily Init**: Check if `DailyPlan` exists for today.
    - *Yes*: Load it.
    - *No*: Trigger `AICoachService.generatePlan(user)` -> Save to DB -> Return.
3.  **Tracking**:
    - User adds `Meal` -> Update `DailyLog` -> Update `ExpenseLog`.
    - Updates flow efficiently using Riverpod streams from local DB or backend.
