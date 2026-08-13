final class AppStrings {
  const AppStrings._();

  //----------------------------------------------------------------------
  // 🔠 FONT NAMES
  //----------------------------------------------------------------------
  static const String interFont = 'Inter';
  static const String nunitoFont = 'Nunito';

  //----------------------------------------------------------------------
  // ❌ FAILURE MESSAGES
  //----------------------------------------------------------------------
  static const String parseFailure = 'Erro ao processar dados';
  static const String cacheFailure = 'Erro ao acessar os dados locais';
  static const String unknownFailure = 'Erro inesperado';

  //----------------------------------------------------------------------
  // 📱 UI TEXTS
  //----------------------------------------------------------------------
  static const String emptyConstellation =
      'This constellation is quiet right now...';
  static const String emptyNotes =
      'The night sky is still waiting for its stars...';
  static const String emptySearchingNotes =
      'No stars shining with that name...';

  static const String closedHeader = 'The stillness of space...';
  static const String searchStar = 'Search for a star...';
  static const String returnText = 'Back to the sky';
  static const String saveNote = 'Save this star';
  static const String setConstellation = 'Guide this star...';
  static const String withoutBodyNote = 'No details added...';

  static const List<String> editNotePrompts = [
    "What thought is orbiting you right now?",
    "Which idea would you like to turn into a star today?",
    "What’s drifting across your sky right now?",
    "Release the words and let your mind drift.",
    "Which spark of an idea do you want to capture here?",
    "A calm space for whatever you’re feeling.",
    "What keeps echoing in your mind?",
    "Connect the dots: what’s on your mind?",
    "A pause to capture what matters.",
    "Take your time and let it flow... where would you like to begin?",
  ];

  //----------------------------------------------------------------------
  // 🆔 CONSTELLATIONS IDs
  //----------------------------------------------------------------------
  static const String driftingThoughtsId = 'drifting_thoughts';
  static const String quietMomentsId = 'quiet_moments';
  static const String tomorrowsOrbitId = 'tomorrows_orbit';
  static const String deepFocusId = 'deep_focus';

  //----------------------------------------------------------------------
  // ⭐ CONSTELLATIONS TEXTS
  //----------------------------------------------------------------------
  static const String loneStarName = 'Lone Star';

  static const String driftingThoughtsName = 'Drifting Thoughts';
  static const String driftingThoughtsDescription =
      'A safe orbit to unload your mind before sleep. Leave your random thoughts, worries, and midnight questions here so you can rest in peace.';
  static const String driftingThoughtsExample1 =
      '"Why does the universe feel so much vaster when the house is completely quiet?"';
  static const String driftingThoughtsExample2 =
      '"Why did I say that in the presentation three years ago?"';

  static const String quietMomentsName = 'Quiet Moments';
  static const String quietMomentsDescription =
      'Let the brightest little stars of warmth and calm shine through your night. A gentle space to remember what brought you peace, without any pressure for perfection.';
  static const String quietMomentsExample1 =
      '"Thought about time while watching the rain fall."';
  static const String quietMomentsExample2 =
      '"Finally solved that issue that was draining my energy."';

  static const String tomorrowsOrbitName = "Tomorrow's Orbit";
  static const String tomorrowsOrbitDescription =
      'Your gentle cosmic roadmap for the day ahead. Set intentional, realistic steps without the stress of rigid to-do lists. Just steady progress.';
  static const String tomorrowsOrbitExample1 =
      '"Three gentle steps for tomorrow: reply to the design team, drink 2L of water, and sketch the new project."';
  static const String tomorrowsOrbitExample2 =
      '"Schedule the vet appointment in the afternoon."';

  static const String deepFocusOrbitName = 'Deep Focus';
  static const String deepFocusOrbitDescription =
      'Your personal observatory for learning and building. Store study notes, book quotes, work insights, and project ideas under a calm desk lamp vibe.';
  static const String deepFocusOrbitExample1 =
      '"Key points to bring up in the meeting:"';
  static const String deepFocusOrbitExample2 =
      '"["...book quote"]. This passage makes me think that:"';
}
