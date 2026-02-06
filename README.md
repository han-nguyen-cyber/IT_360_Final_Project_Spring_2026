# IT_360_Final_Project_Spring_2026
Group Project Repo - Linux Live Response Digital Forensics Tool

## Team Members
* Member 1: Han Nguyen
* Member 2: London Morris
* Member 3: Ninel Benitez

## Project Idea
We will design and implement a Linux Live Response Digital Forensics Collector, using Bash scripting. The tool will perform read-only evidence collection on a running Linux system, preserving forensic artifacts while maintaining forensic integrity. 

In addition to the baseline system's artifact collection, the tool includes a persistence detection module that identifies common Linux persistence mechanisms employed by attackers, such as scheduled tasks, startup scripts, and other methods.

This project will demonstrate how scripting can automate forensic workflows while adhering to core principles of digital forensics, such as data integrity, repeatability, and chain of custody.

## Project Scope
1. Baseline Artifact Collection:
The tool will collect the following artifacts with read-only access:
    - System Information:
        - Kernel and OS info
        - Hostname and timezone
        - Hardware info (CPU, memory)
    - User and Authentication Data:
        - Currently logged-in users
        - Login history
        - User account listings
        - Bash history files
    - Process and Services Information:
        - Running processes
        - Loaded kernel modules
        - Active systemd services
    - Network Artifacts:
        - Active network connections
        - Listening ports
        - Network interfaces and routing table
    - Log Files:
        - Authentication logs
        - System logs
        - Journal logs
  2. Persistence Detection:
The tool will scan for and flag common persistence mechanisms, such as:
        - Startup scripts (/etc/rc.local, /etc/init.d/)
        - User and system cron jobs
        - Systemd services and timers
        - SUID/SGID binaries
    
## Project Purpose
There is a lack of immediate forensic visibility during incidents. When a system is compromised, responders must quickly answer questions such as "Who is logged in?", "What processes are running?", and "Has persistence been established?" Manually running commands, however, is time-consuming, error-prone, and difficult to document consistently.

This tool streamlines the process with exceptional speed and accuracy, significantly reducing the risk of contamination. It addresses the challenges of inconsistent and potentially unsafe forensic evidence collection on live Linux systems by delivering a standardized, defensible live-response solution that reliably preserves critical system and persistence artifacts for thorough investigation.

## Project Timeline
- Week 1: Planning

- Weeks 2-3: Baseline Artifact Collection

- Week 4-5: Persistence Detection Module 

- Weeks 6-7: Testing and Documentation

