import google.generativeai as genai
import os
import sys

genai.configure(api_key=os.getenv("GEMINI_API_KEY"))

model = genai.GenerativeModel("gemini-1.5-flash")

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
