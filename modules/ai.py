import google.generativeai as genai
import os
import sys

# This is the ai.py script.
# Interacts with the Gemini API to perform automated forensics analysis and reporting. 

# Configuring the Gemini API client using an API key stored in an .env file, isolated on our local system.
# The key should not be included in the source code, for security reasons. 
genai.configure(api_key=os.getenv("GEMINI_API_KEY"))
# Select model version: this one was chosen for its long context windows, which is ideal for processing long forensic log files.
model = genai.GenerativeModel("gemini-1.5-flash")

# CREDO, which was discussed in class, was utilized for ideal prompt engineering.
def analyze_data(data):

    prompt = f"""
[C - CONTEXT]
You are analyzing live-response digital forensic data collected from a Linux system.
The data includes system info, processes, network activity, logs, and persistence artifacts.

[R - ROLE]
You are a senior digital forensics analyst specializing in incident response and threat detection.

[E - EXPECTATIONS]
Analyze the provided data and:
- Identify suspicious processes or commands
- Detect potential persistence mechanisms
- Highlight anomalies or indicators of compromise (IOCs)
- Correlate findings where possible

[D - DELIVERABLES]
Provide output in the following structured format:

1. Summary of Findings
2. Suspicious Indicators (bullet points)
3. Detected Persistence Mechanisms
4. Notable Anomalies
5. Recommended Next Steps

[O - OUTPUT CONSTRAINTS]
- Be concise and technical
- Do NOT make assumptions without evidence
- Clearly state uncertainty when applicable
- Do NOT hallucinate missing data
- Base conclusions ONLY on the provided input

# After the model is prompted, the generated response is captured in a file 
[DATA]
{data}
"""

    response = model.generate_content(prompt)
    return response.text


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 ai.py <file>")
        sys.exit(1)

    with open(sys.argv[1], "r") as f:
        data = f.read()

    result = analyze_data(data)
    print(result)
