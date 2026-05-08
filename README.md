# VoterFlow Web - Election Process of India Guide & AI Assistant

VoterFlow Web is a highly visual, responsive Flutter Web application designed to educate citizens on the Indian election process. It includes a comprehensive roadmap of voter registration, verification, polling procedures, and an integrated generative AI assistant trained on the Election Commission of India (ECI) guidelines.

## Features

- **Responsive Landing & Dashboard**: Beautiful dark-mode themed interface showcasing the visual timeline of the election process.
- **Indian Election Information**: Deep-dive sections explaining voter registration (Form 6, Form 8, NVSP/Voters Service Portal), searching the Electoral Roll, and polling day workflows with EVMs and VVPATs.
- **AI Chatbot**: Intelligent interactive chatbot powered by Google Gemini (`gemini-2.5-flash`), answering user queries about voting in India.
- **Ready for Cloud Run**: Configured with a robust Nginx Alpine server for high-performance single-page application hosting on Google Cloud Run.

## Local Development

To run this project locally:

1. **Prerequisites**: Ensure you have Flutter SDK installed (`stable` channel).
2. **Environment Setup**: Add your Gemini API Key inside a `.env` file at the project root:
   ```env
   GEMINI_API_KEY=your_api_key_here
   ```
3. **Run Dev Server**:
   ```bash
   flutter run -d chrome --web-port 8080
   ```

## Production Deployment to Cloud Run

The project is structured with optimized deployment assets to serve directly via Google Cloud Run:

1. **Build Web Files**:
   ```bash
   flutter build web --release
   ```
2. **Deploy via gcloud**:
   ```bash
   gcloud run deploy voter-flow-web --source . --project YOUR_PROJECT_ID --region us-central1 --allow-unauthenticated
   ```

---

*Built with ❤️ for Doing Timepass in Exam.*
 
