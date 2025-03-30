import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  late final GenerativeModel model;

  AIService() {
    model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: 'AIzaSyAod3bstAG3bzu5jjOjHuJHcyuUBNvjPFU');
  }

  Future<String> evaluateAnswer(String answer) async {
    final prompt = "Evaluate the following interview answer: '$answer'. "
        "Rate it from 1-10 based on clarity, relevance, and correctness. "
        "Provide a short explanation for the score.";

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error evaluating answer.";
  }

  Future<String> compareResumeAndJobDescription(
      String resumeText, String jobDescription) async {
    final prompt = """
  Compare the following resume text with the job description and provide feedback:
  
  **Resume Text:**
  $resumeText
  
  **Job Description:**
  $jobDescription
  
  Tasks:
  1. Rate the resume's relevance to the job description on a scale of 0-100.
  2. Identify missing keywords or skills in the resume compared to the job description.
  3. Suggest improvements to the resume to better match the job description.
  4. Provide a revised version of the resume based on the following template:
  
  **Resume Template:**
  Name: [Your Name]
  Job Apply: [Job Title]
  Email: [Your Email]
  Phone Number: [Your Phone Number]
  LinkedIn: [Your LinkedIn Profile]
  Portfolio: [Your Portfolio/Website]
  Address: [Your Address]

  Education:
  - [Degree], [University], [Graduation Year]

  Certifications:
  - [Certification Name], [Year]
  - [Certification Name], [Year]

  Professional Summary:
  - A highly motivated [Job Title] with [X years] of experience in [Field]. Skilled in [Key Skill 1], [Key Skill 2], and [Key Skill 3]. Proven track record of [Quantifiable Achievement].

  Technical Skills:
  - [Skill 1], [Skill 2], [Skill 3], [Skill 4]

  Experience:
  - [Job Title] at [Company], [Start Date] - [End Date]
    - [Action Verb] [Task/Responsibility] to achieve [Quantifiable Result].
    - [Action Verb] [Task/Responsibility] to improve [Outcome].

  Projects:
  - [Project Name] ([Technologies Used])
    - [Brief description of the project, your role, and outcomes].

  Achievements:
  - [Achievement 1]
  - [Achievement 2]

  Languages:
  - [Language 1] (Proficiency Level)
  - [Language 2] (Proficiency Level)

  References:
  - Available upon request.
  
  Format your response as follows:
  Matching Score: [Score]%
  Missing Keywords:\n[Keywords]
  Suggestions:\n[Suggestions]
  Revised Resume:\n[Revised Resume]
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error comparing resume and job description.";
  }

  Future<String> generateInterviewQuestions(String jobTitle, String companyName, String jobDesc, String responsibilities) async {
    final prompt = """
    You are an HR interviewer of $companyName who conducting an interview for a fresh graduate applying for the position of $jobTitle.

    **Job Description:**
    $jobDesc
    
    **Responsibilities:**
    $responsibilities
    
    Generate 5 relevant interview questions based on the job role.
    """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error generating questions.";
  }

  Future<String> evaluateInterviewResponses(Map<String, String> responses) async {
    final prompt = """
    Evaluate the following interview responses, provide feedback, and give recommendations for improvement.
    
    ${responses.entries.map((e) => "**Question:** ${e.key}\n**Response:** ${e.value}").join("\n\n")}
    
    Tasks:
    1. Provide feedback on each response.
    2. Suggest improvements for each answer.
    3. Generate a final interview report including:
       - Technical Skills Rating (1-10)
       - Communication Skills Rating (1-10)
       - Overall Score (1-10)
    
    Format your response as follows:
    
    **Interview Evaluations:**
    
    1. **Question:** [Question]
       **Interviewee Response:** [Response]
       **Feedback:** [Feedback]
       **Recommendation:** [Recommendation]
    
    (Repeat for all responses)
    
    **Final Interview Report:**
    - **Technical Skills Rating:** [Score]/10
    - **Communication Skills Rating:** [Score]/10
    - **Overall Score:** [Score]/10
    """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error evaluating interview.";
  }
}

