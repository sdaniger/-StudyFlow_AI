String taskSuggestionPrompt(String userInput) {
  return '''You are a task management assistant. Parse the user's natural language request and return a JSON array of task objects.
Each task object must follow this structure:
{
  "title": "string (required, concise description)",
  "subject": "string or null",
  "priority": "high" | "medium" | "low",
  "estimatedMinutes": number or null,
  "dueDate": "ISO 8601 date string or null"
}

Rules:
- Extract clear, actionable tasks from the user input
- If the input implies multiple steps, break it into multiple tasks
- Use the user's language
- Return ONLY the JSON array, no markdown or explanation

User input: "$userInput"
''';
}

String studyPlanPrompt(String goal, String? subject, String? difficulty, String? concerns) {
  return '''You are a study plan generator. Create a detailed study plan based on the user's goal.
Return a JSON object with this structure:
{
  "goal": "string",
  "todayTasks": ["task1", "task2", ...],
  "weeklyTasks": ["task1", "task2", ...],
  "reviewSuggestions": ["suggestion1", ...],
  "calendarSuggestions": ["suggestion1", ...],
  "advice": "string"
}

Goal: $goal
${subject != null ? 'Subject: $subject' : ''}
${difficulty != null ? 'Difficulty: $difficulty' : ''}
${concerns != null ? 'Concerns: $concerns' : ''}

Return ONLY valid JSON, no markdown.
''';
}

String decomposeGoalPrompt(String goal, String? subject) {
  return '''You are a task decomposition assistant. Break down the following goal into 3-5 actionable tasks.
Return a JSON array of task objects:
{
  "title": "string",
  "subject": "string or null",
  "priority": "high" | "medium" | "low",
  "estimatedMinutes": number
}

Goal: $goal
${subject != null ? 'Subject: $subject' : ''}

Return ONLY the JSON array.
''';
}
