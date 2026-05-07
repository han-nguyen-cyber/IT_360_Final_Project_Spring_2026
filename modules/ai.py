from google import genai
import os
import sys

# API key check
api_key = os.getenv("GEMINI_API_KEY")

if not api_key:
    print("ERROR: GEMINI_API_KEY not set")
    sys.exit(1)

# Client setup
client = genai.Client(api_key=api_key)

# Input check
if len(sys.argv) < 2 or not sys.argv[1]:
    print("Usage: python3 ai.py <input_file>")
    sys.exit(1)

input_file = sys.argv[1]

# Read forensic data
try:
    with open(input_file, "r") as f:
        forensic_data = f.read()
except FileNotFoundError:
    print(f"ERROR: File not found: {input_file}")
    sys.exit(1)

# CREDO PROMPT
prompt = f"""
[C - CONTEXT]
You are analyzing Linux live-response forensic artifacts collected during an incident response investigation.

[R - ROLE]
You are a senior SOC analyst and digital forensics investigator.

[E - EXPECTATIONS]
Analyze the forensic data for:
- suspicious processes
- persistence mechanisms
- unusual network activity
- indicators of compromise
- anomalous behavior

[D - DELIVERABLES]
Return:
1. Executive Summary
2. Suspicious Findings
3. Persistence Findings
4. Network Findings
5. Risk Assessment
6. Recommended Actions

[O - OUTPUT CONSTRAINTS]
- Be evidence-based only
- Do not hallucinate
- Clearly state uncertainty
- Use concise technical language

[FORENSIC DATA]
{forensic_data}
"""

# Gemini request:
response = client.models.generate_content(
    model="gemini-2.0-flash",
    contents=prompt
)

# Output
print("AI Forensic Analysis:")
print(response.text)
