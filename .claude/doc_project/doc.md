# [cite_start]Family Budget - Product Documentation (MVP V1) [cite: 1]

## [cite_start]1. Project Overview [cite: 2]

* [cite_start]**Product Name:** Family Budget [cite: 3, 4]
* [cite_start]**Product Type:** Family Financial Management Application [cite: 5, 6]
* [cite_start]**Platforms:** Android, iOS [cite: 7, 8, 9]
* [cite_start]**Technology:** Flutter, Firebase [cite: 10, 11, 12]
* [cite_start]**Languages:** Arabic, English [cite: 13, 14, 15]
* [cite_start]**Supported Region:** Arab countries with multi-currency support. [cite: 16, 17]

---

## [cite_start]2. Product Vision [cite: 18]

[cite_start]بناء تطبيق يساعد الأسر على إدارة المال بشكل بسيط ومنظم، ويحول إدارة المصروف من عملية عشوائية إلى نظام واضح يساعد الأبناء على تعلم المسؤولية المالية. [cite: 19]

---

## [cite_start]3. Problem Statement [cite: 20]

[cite_start]داخل الكثير من الأسر: [cite: 21]
* [cite_start]المسؤول عن المصروف لا يعرف أين تذهب الأموال بالتفصيل. [cite: 22]
* [cite_start]الطلبات اليومية تسبب ضغطًا وتكرارًا. [cite: 23]
* [cite_start]الأبناء لا يتعلمون إدارة المال. [cite: 25]
* [cite_start]لا يوجد سجل واضح للمصروفات. [cite: 26]
* [cite_start]المتابعة تكون بالذاكرة وليس بالبيانات. [cite: 27]

---

## [cite_start]4. Solution [cite: 29]

[cite_start]يقدم نظامًا عائليًا **Family Budget**: [cite: 30]
* [cite_start]الأب يحدد الميزانيات. [cite: 31]
* [cite_start]أفراد الأسرة يطلبون المصروف من خلال التطبيق. [cite: 32]
* [cite_start]كل طلب له سبب. [cite: 33]
* [cite_start]الموافقات تحفظ التاريخ. [cite: 34]
* [cite_start]التقارير توضح نمط الإنفاق. [cite: 35]
* [cite_start]نظام نقاط يساعد على تعليم الادخار. [cite: 36]

---

## [cite_start]5. Target Users [cite: 37]

* **Primary User:**
  * [cite_start]**Family Manager:** غالباً الأب أو المسؤول المالي. [cite: 38, 39, 40]
* **Secondary Users:**
  * [cite_start]**Co-Manager:** الأم بصلاحيات محددة. [cite: 41, 42, 43]
  * [cite_start]**Family Member:** الأبناء أو أفراد الأسرة. [cite: 44, 45]

---

## [cite_start]6. User Roles & Permissions [cite: 46]

### [cite_start]Family Manager [cite: 47]
[cite_start]**صلاحيات:** [cite: 48]
* [cite_start]Create Family / Add Members [cite: 49]
* [cite_start]Set Budgets / Edit Budgets [cite: 50]
* [cite_start]Approve Requests / Reject Requests [cite: 51, 52]
* [cite_start]View Reports [cite: 53]
* [cite_start]Create Goals [cite: 54]
* [cite_start]Create Rewards [cite: 55]
* [cite_start]Manage Permissions [cite: 56]

### [cite_start]Co-Manager [cite: 57]
[cite_start]**حسب الصلاحيات:** [cite: 58]
* [cite_start]**View & Approve:** Approve Requests, View Reports. [cite: 59, 60, 61]
* [cite_start]**Manage:** بعض البيانات. [cite: 63]

### [cite_start]Family Member [cite: 64]
[cite_start]**يرى فقط بياناته:** [cite: 65]
* [cite_start]My Budget [cite: 66]
* [cite_start]My Requests [cite: 67]
* [cite_start]My Points [cite: 68]
* [cite_start]My Rewards [cite: 69]

> [cite_start]**ملاحظة:** لا يرى ميزانيات الآخرين، طلباتهم، أو تقاريرهم. [cite: 71, 72, 73, 74]

---

## [cite_start]7. Account Types [cite: 76]

[cite_start]عند التسجيل يختار المستخدم: [cite: 77]
* [cite_start]**Family Budget** [cite: 78]
* [cite_start]أو **Personal Budget** [cite: 80]

---

## [cite_start]8. Authentication [cite: 81]

### [cite_start]Register [cite: 82]
* [cite_start]**Fields:** First Name, Last Name, Email, Password, Confirm Password [cite: 83, 84, 85, 86, 87, 88]

### [cite_start]Login [cite: 89]
* [cite_start]**Fields:** Email, Password [cite: 90, 91]

### [cite_start]Supported Third-Party Providers [cite: 92]
* [cite_start]Google Sign In [cite: 93]
* [cite_start]Apple Sign In [cite: 94]

---

## [cite_start]9. Family Creation Flow [cite: 95]

[cite_start]بعد اختيار **Family Mode**: [cite: 96]

* [cite_start]**Step 1: Create Family** [cite: 97, 98]
  * [cite_start]Required: Family Name [cite: 99, 100]
* [cite_start]**Step 2: Add Members** [cite: 101, 102]
  * [cite_start]Data: Name, Role, Email Invitation [cite: 103, 104, 105, 106]
  * [cite_start]Roles: Co-Manager, Family Member [cite: 107, 108, 109]
* [cite_start]**Step 3: Set Budgets** [cite: 110, 111]
  * [cite_start]لكل عضو: Monthly Budget [cite: 112, 113]
  * [cite_start]*Example:* Ahmed: 1000 EGP [cite: 114, 115, 116]
* [cite_start]**Step 4: Create Goal (Optional)** [cite: 117, 118, 119]
  * [cite_start]Fields: Goal Name, Amount, Date [cite: 120, 121, 122, 123]
* [cite_start]**Step 5: Create Rewards (Optional)** [cite: 125, 126]
  * [cite_start]Fields: Reward Name, Points Required [cite: 127, 128, 129]

---

## [cite_start]10. Main Application Structure [cite: 130]

### [cite_start]Navigation [cite: 131]
[cite_start]**Bottom Navigation:** [cite: 132]
1. [cite_start]Home [cite: 133]
2. [cite_start]Requests [cite: 134]
3. [cite_start]Family [cite: 135]
4. [cite_start]Reports [cite: 136]
5. [cite_start]More [cite: 137]

---

## [cite_start]11. Parent Home [cite: 138]

[cite_start]**Components:** [cite: 139]
* [cite_start]**Family Overview Card:** Contains Family Name, Members Count, Budget Status [cite: 140, 141, 142, 143, 144]
* [cite_start]**Budget Summary:** Shows Total Budget, Used, Remaining [cite: 145, 146, 147, 148, 149]
* [cite_start]**Goal Card:** Shows Goal, Progress [cite: 150, 151, 152, 153]
* [cite_start]**Requests Preview:** Latest requests. [cite: 154, 155]
* [cite_start]**Insights:** Examples: Spending improved, Budget warning [cite: 156, 157, 158, 159]

---

## [cite_start]12. Requests System [cite: 160]

### [cite_start]Create Request [cite: 161]
[cite_start]Member enters: Amount, Category, Description [cite: 162, 163, 164, 165]
> [cite_start]**Note:** Category is created by Family Manager. [cite: 166, 167]

### [cite_start]Approval Logic [cite: 168]
[cite_start]Manager defines **Auto Approval Limit**. [cite: 169]
* *Example:* Limit = 100 EGP. [cite_start]If Request = 80 EGP $\rightarrow$ Approved automatically & Notification sent. [cite: 170, 171, 172, 173, 174, 175, 176, 177]
* [cite_start]Above limit $\rightarrow$ Requires approval. [cite: 178, 179]

### [cite_start]Request Status [cite: 180]
* [cite_start]States: Pending, Approved, Rejected [cite: 181, 182, 183, 184]

### [cite_start]Actions [cite: 185]
Manager can:
* [cite_start]**Approve:** Approve, Modify amount, Add note [cite: 186, 187, 188, 189]
* [cite_start]**Reject:** Required: Reason, Optional: Comment [cite: 190, 191, 192, 193, 194]

---

## [cite_start]13. Budget System [cite: 195]

### [cite_start]Monthly Cycle [cite: 196]
* [cite_start]Starts automatically on the first day of the month. [cite: 197, 198]
* **Budget Reset:** Previous budget remains. New month starts with the same assigned budget. [cite_start]Manager can edit. [cite: 199, 200, 201, 202]

### [cite_start]Extra Budget [cite: 203]
[cite_start]Recorded as: Original Budget + Extra Allowance. [cite: 204, 205, 206]
* [cite_start]Includes: Amount, Reason, Date [cite: 207, 208, 209, 210]

---

## [cite_start]14. Points System [cite: 211]

* [cite_start]**Purpose:** Teach saving behavior. [cite: 212, 213]
* **Calculation:** Based on saving from budget. [cite_start]Points calculated at the end of the month. [cite: 214, 215, 224]
* [cite_start]**Conversion:** Defined by parent. [cite: 225, 226]
* *Example:* Budget: 1000 | Spent: 600 | [cite_start]Saved: 400. [cite: 216, 217, 218, 219, 220, 221, 222]

---

## [cite_start]15. Goals System [cite: 227]

* [cite_start]**Current Status:** One active goal. [cite: 228, 229]
* [cite_start]**Future Status:** Multiple goals. [cite: 230, 231]
* [cite_start]**Goal Contains:** Name, Target Amount, Saved Amount, Progress, Contributors, History [cite: 232, 234, 235, 236, 237, 238, 239]
* [cite_start]**Saving Options (Manager chooses):** Add to Goal OR Add to Member Balance. [cite: 240, 241, 242, 243]

---

## [cite_start]16. Rewards System [cite: 244]

* [cite_start]Created by parent. [cite: 245]
* [cite_start]Member sees only own rewards. [cite: 246, 247]
* [cite_start]*Example:* 5000 points = Movie Night. [cite: 247]

---

## [cite_start]17. Member Profile [cite: 247]

* [cite_start]**Contains:** Avatar, Name, Role [cite: 247]
* [cite_start]**Financial Overview:** Budget, Used, Remaining [cite: 247]
* [cite_start]**History:** Expenses, Requests [cite: 247]
* [cite_start]**Actions (Manager):** Edit Budget, Add Reward [cite: 247]

---

## [cite_start]18. Reports System [cite: 247]

### [cite_start]Monthly Reports [cite: 247]
[cite_start]Shows: Total Spending, Budget, Remaining [cite: 247, 248]

### [cite_start]Analysis & Charts [cite: 247]
* [cite_start]By Members / By Categories [cite: 247]
* [cite_start]Charts: Pie Chart, Bar Chart [cite: 247]

### [cite_start]Comparison & Export [cite: 247]
* [cite_start]Current month vs previous month. [cite: 247]
* [cite_start]**Export:** PDF Report [cite: 249]

---

## [cite_start]19. Notifications [cite: 249]

[cite_start]**Firebase Push Notifications Events:** [cite: 249]
* [cite_start]New Request / Approval / Rejection [cite: 249]
* [cite_start]Budget Warning [cite: 249]
* [cite_start]Goal Progress [cite: 249]
* [cite_start]Reward Unlocked [cite: 249]
* [cite_start]Invitation [cite: 249]

---

## [cite_start]20. Personal Budget Mode [cite: 250]

[cite_start]Separate mode that allows: [cite: 250]
* [cite_start]Personal expenses [cite: 250]
* [cite_start]Personal tracking [cite: 250]
* [cite_start]*Future expansion:* Connect with Family Mode. [cite: 250]

---

## [cite_start]21. Firebase Data Structure (Initial) [cite: 251]

* `users`
* `families`
* `family_members`
* `invitations`
* `budgets`
* `budget_history`
* `requests`
* `transactions`
* `categories`
* `goals`
* `goal_history`
* `rewards`
* `points_history`
* [cite_start]`notifications` [cite: 252]
* [cite_start]`reports` [cite: 252]

---

## [cite_start]22. MVP Version 1 (3 Months) [cite: 252]

[cite_start]**Must Have Features:** [cite: 252]
* Authentication
* Family Creation / Members
* Budgets
* Requests (Approve/Reject)
* Home Dashboard
* Goals
* Basic Reports

---

## [cite_start]23. Future Versions [cite: 252]

### [cite_start]Version 2 [cite: 252]
* Advanced Rewards
* Better Analytics
* More Goal Types
* Family Challenges

### [cite_start]Version 3 [cite: 252]
* Community
* Financial Education Content
* Family Sharing Experiences

---

## [cite_start]24. Product Positioning [cite: 253]

| Family Budget ليس: | والـ: | هو: |
| :--- | :--- | :--- |
| Expense Tracker | Banking App | **Family Financial Companion** |

**تطبيق يساعد الأسرة على:**
* التنظيم
* التواصل
* تعليم الأبناء

---

## [cite_start]25. Core User Loop [cite: 253]