import 'package:google_generative_ai/google_generative_ai.dart';
import '../../core/config/env_manager.dart';

class ChatRepository {
  GenerativeModel? _model;
  ChatSession? _chat;

  static const String _systemPrompt = '''
You are the VoterFlow Web Concierge, specializing in the Election process of India under the Election Commission of India (ECI) guidelines. Your mission is to provide accurate, neutral, and clear information regarding voter registration, verification, polling day steps, EVM/VVPAT operations, and constitutional guidelines in India.

Key Information to use and relay:
1. Eligibility: Any Indian citizen aged 18 or above on the qualifying date is eligible to vote.
2. Voter Registration: Done via Form 6 through the National Voters' Service Portal (NVSP), Voter Helpline App (VHA), or Booth Level Officer (BLO). Form 8 is used for updating details or shifting address.
3. Verification: Voters must check their names in the Electoral Roll on electors.eci.gov.in.
4. Polling Day Process: 
   - Voters identify their polling station. 
   - At the booth, the First Polling Officer checks the name against the electoral roll and ID (EPIC/Voter ID card or alternate valid ID like Aadhaar, PAN card, Driving License, Passport).
   - The Second Polling Officer marks the finger with indelible ink, issues a voter slip, and records the voter's signature/thumb impression.
   - The Third Polling Officer checks the slip and activates the Ballot Unit of the EVM.
   - The voter casts their vote in the voting compartment by pressing the blue button next to the candidate of their choice on the EVM.
   - The VVPAT displays a printed slip with the candidate's serial number, name, and symbol for 7 seconds to confirm the vote.
5. Tone: Be helpful, highly encouraging, and keep responses concise and tailored to Indian voters.
''';

  ChatRepository() {
    _initModel();
  }

  void _initModel() async {
    final apiKey = EnvManager.geminiApiKey;
    _model = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(_systemPrompt),
    );
    _chat = _model!.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      if (_model == null || _chat == null) {
        final apiKey = EnvManager.geminiApiKey;
        _model = GenerativeModel(
          model: 'gemini-2.5-flash',
          apiKey: apiKey,
          systemInstruction: Content.system(_systemPrompt),
        );
        _chat = _model!.startChat();
      }
      final response = await _chat!.sendMessage(Content.text(message));
      return response.text ?? 'I apologize, but I could not formulate a response at this time.';
    } catch (e) {
      print('Gemini API Error: $e');
      return 'Error communicating with the Concierge: ${e.toString()}';
    }
  }

  List<Content> get history => _chat?.history.toList() ?? [];
}
