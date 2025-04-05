import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  late final GenerativeModel model;

  AIService() {
    model = GenerativeModel(
        model: 'gemini-2.0-flash',
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
Compare the following resume with the job description and provide analysis and improvements, ensuring the final version is optimized for Applicant Tracking Systems (ATS).

**Resume Text:**
$resumeText

**Job Description:**
$jobDescription

**Tasks:**
1. Rate the resume's relevance to the job description on a scale of 0-100.
2. Identify missing keywords or skills that are present in the job description but not in the resume.
3. Suggest specific improvements to align the resume more closely with the job description and current market trends in this field.
4. Provide an **ATS-optimized** revised version of the resume using the template below.

**ATS Formatting Guidelines:**
- Use standard headings like Education, Experience, Skills, Projects, etc.
- Avoid tables, columns, graphics, images, or unusual fonts.
- Use bullet points and simple formatting.
- Ensure compatibility with resume screening systems.
- Match terminology and keywords from the job description.
- Use consistent structure and clear, quantifiable achievements.

**ATS-Optimized Resume Template:**
Name: [Your Name]  
Job Title Applied For: [Job Title]  
Email: [Your Email]  
Phone: [Your Phone Number]  
LinkedIn: [LinkedIn URL]  
Portfolio: [Portfolio URL]  
Location: [City, Country]  

**Professional Summary:**  
- [1-2 sentences summarizing your career background, strengths, and goals.]

**Education:**  
- [Degree], [Institution], [Graduation Year]  

**Certifications:**  
- [Certification Name], [Year]  

**Skills:**  
- [Skill 1], [Skill 2], [Skill 3], [Skill 4], [Skill 5]  

**Experience:**  
- [Job Title], [Company Name], [Start Date] – [End Date]  
  - [Action verb] [Responsibility or task] resulting in [Outcome].  
  - [Action verb] [Responsibility or task] with focus on [Result/Impact].  

**Projects:**  
- [Project Title] – [Technologies Used]  
  - [Brief project description, your role, and outcomes.]

**Achievements:**  
- [Achievement 1]  
- [Achievement 2]  

**Languages:**  
- [Language 1] (Proficiency)  
- [Language 2] (Proficiency)  

**References:**  
Available upon request.

**Response Format:**
Matching Score: [Score]%  
Missing Keywords:\n[Keywords]  
Suggestions:\n[Suggestions]  
Revised Resume:\n[Revised Resume]
""";

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error comparing resume and job description.";
  }


  Future<String> generateInterviewQuestionsWithHints(
      String jobTitle, String companyName, String jobDesc, String responsibilities) async {
    final prompt = """
  You are an HR interviewer at $companyName conducting an interview for a fresh graduate applying for the position of $jobTitle.

  **Job Description:**
  $jobDesc

  **Responsibilities:**
  $responsibilities

  Generate 5 relevant interview questions based on the job role.
  For each question, also generate a helpful hint that guides the candidate in answering effectively.
  
  Format the response as follows:
  Question 1: <question>
  Hint 1: <hint>

  Question 2: <question>
  Hint 2: <hint>

  ...
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    print(response.text);
    return response.text ?? "Error generating questions and hints.";
  }



  Future<String> evaluateInterviewResponses(Map<String?, String?> responses) async {
    final prompt = """
    Evaluate the following interview responses and provide feedback.
    
    ${responses.entries.map((e) => "**Question:** ${e.key}\n**Response:** ${e.value}").join("\n\n")}
    
    Tasks:
    1. Provide feedback and score on each response.
    2. Generate a final interview report including:
       - Technical Skills Rating (1-10)
       - Communication Skills Rating (1-10)
       - Overall Score (1-10)
       
    Format your response as a JSON object with the following structure:
    {
    "interviewEvaluations": [
    {
      "question": "[Question]",
      "intervieweeResponse": "[Response]",
      "feedback": "[Feedback]",
      "score": "[Score]/10"
    },
    // ... more evaluations
  ],
    "finalInterviewReport": {
      "technicalSkillsRating": "[Score]/10",
      "communicationSkillsRating": "[Score]/10",
      "overallhrIVScore": "[Score]/10"
    }
  }
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    print(response);
    return response.text ?? "Error evaluating interview.";
  }

  Future<String> getJobOpenings(String jobTitle) async {
    final prompt = """
       Given the job title "$jobTitle", provide the estimated number of job openings for the years 2020, 2021, 2022, 2023, and 2024.
      The response should be in JSON format like:
      {
        "2020": 15000,
        "2021": 18000,
        "2022": 21000,
        "2023": 25000,
        "2024": 28000
      }
      Do NOT include any extra text, explanation, or comments.
    """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? "Error get job openings.";
  }

  Future<String> getCommonSkills(String jobTitle) async {
    final prompt = """
      Given the job title "$jobTitle", provide a list of common skills required for this job.
    The response should be in valid JSON format like:
    {
      "skills": ["Java", "Python", "MySQL", "MongoDB", "Node.js", "AWS"]
    }
    Do NOT include any extra text, explanation, or comments.
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '{"skills":[]}';
  }

  Future<String> getTopHiringCompanies(String jobTitle) async {
    final prompt = """
      Given the job title "$jobTitle", provide a list of the top 3 hiring companies for this role.
    The response should be in JSON format like:
    {
      "companies": [
        "Google",
        "Amazon",
        "Microsoft"
      ]
    }
    Do NOT include any extra text, explanation, or comments.
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '{"companies":[]}';
  }

  Future<String> getSalary(String jobTitle) async {
    final prompt = """
      Given the job title "$jobTitle", provide the estimated salary range in Malaysia.
    The response should be in JSON format like:
    {
     "salary": "RM 3000 - RM 5000"
    }
    Do NOT include any extra text, explanation, or comments.
  """;

    final response = await model.generateContent([Content.text(prompt)]);

    return response.text ?? '{"salary": "Unknown"}';
  }

  Future<String> getRecommend(String fieldStudy,String jobRole,String hardSkill) async {
    final prompt = """
       Given the field of study "$fieldStudy", job role "$jobRole", and hard skills "$hardSkill", provide job recommendations in Malaysia.
    The response should be in JSON format like:
    {
      "recommendations": [
        {
          "title": "Software Engineer",
          "salary": "RM 3000 - RM 3500",
          "skills": "Java, Python, C++",
          "match": "85% Match | Interest · Skills · Education"
        }
      ]
    }
    Only provide 3 jobs and the three most important skills.The word of title just 3.
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '{"recommendations": []}';
  }

  Future<String> getRelevant(String fieldStudy,String jobRole,String hardSkill) async {
    final prompt = """
      Given the field of study "$fieldStudy", job role "$jobRole", and hard skills "$hardSkill", provide job relevancy in Malaysia.
    The response should be in JSON format like:
    {
      "relevant": [
        {
          "title": "Software Engineer",
          "salary": "RM 3000 - RM 3500",
          "skills": "Java, Python, C++",
          "match": "85% Match | Interest · Skills · Education"
        }
      ]
    }
    Only provide 3 jobs and the three most important skills.The word of title just 3.
  """;

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? '{"relevant": []}';
  }
}