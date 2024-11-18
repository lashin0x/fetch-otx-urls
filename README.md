# Fetch OTX URLs

## Overview
`fetch-otx-urls` is a lightweight bash script designed to automate the retrieval of all URLs associated with a specific domain using AlienVault's Open Threat Exchange (OTX) API. The script handles paginated API responses and stores the results in a file for easy analysis.

---

## Features
- Fetches URLs for any domain listed in AlienVault's OTX.
- Automatically handles pagination to retrieve all available results.
- Saves URLs to a file for further usage or analysis.

---

## Requirements
This script requires:
- **`curl`**: For sending API requests.
- **`jq`**: For parsing JSON responses.

---

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/lashin0x/fetch-otx-urls.git
   cd fetch-otx-urls
   chmod +x fetch-otx-urls
