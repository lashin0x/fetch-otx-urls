#!/bin/bash

# Function to display help message
display_help() {
    echo "Usage: $0 [options]"
    echo
    echo "Options:"
    echo "  -h, --help          Display this help message"
    echo "  -d, --domain        Specify the target domain"
    echo
    echo "This script fetches URLs associated with the specified domain from AlienVault's OTX API."
    echo "The results are saved in 'urls.txt'."
    echo
}

# Parse command-line arguments
while [[ "$1" != "" ]]; do
    case $1 in
        -h | --help)  # Show help message
            display_help
            exit 0
            ;;
        -d | --domain)  # Get domain argument
            shift
            DOMAIN=$1
            ;;
        *)  # Unknown option
            echo "Invalid option: $1"
            display_help
            exit 1
            ;;
    esac
    shift
done

# If domain is not specified, ask for it
if [[ -z "$DOMAIN" ]]; then
    read -p "Enter the target domain: " DOMAIN
    if [[ -z "$DOMAIN" ]]; then
        echo "No domain entered. Exiting."
        exit 1
    fi
fi

# Base API URL
BASE_URL="https://otx.alienvault.com/api/v1/indicators/domain/$DOMAIN/url_list"
# Starting page
PAGE=1
# Output file to save results
OUTPUT_FILE="urls.txt"

# Clear the output file if it exists
> "$OUTPUT_FILE"

echo "Fetching URLs for $DOMAIN..."

while true; do
    echo "Fetching page $PAGE..."
    
    # Send request and fetch data
    DATA=$(curl -s "$BASE_URL?limit=100&page=$PAGE" | jq -r '.url_list[].url')
    
    # Check if data exists
    if [[ -z "$DATA" ]]; then
        echo "No more pages. Data fetching completed."
        break
    fi
    
    # Save data to the output file
    echo "$DATA" >> "$OUTPUT_FILE"
    
    # Move to the next page
    ((PAGE++))
done

echo "All URLs saved in $OUTPUT_FILE"
