# Customer Code Utility

## Purpose

The purpose of this utility is to facilitate comparisons between NYPL's ReCap customer code mapping and the cross-partner spreadsheet of customer codes, so that we can keep in sync with our partners.

## Requirements

- Ruby 2.7 or later

## Environment Variables

- `SPREADSHEET_FILE`: The path to your local copy of the cross-partner spreadsheet
- `GITHUB_URL`: The url for the ReCap customer code mapping on our GitHub account. Make sure you use the raw version

## Use

- Clone this repo and move to the relevant directory
- Create a `.env` file
- Copy `.env_sample` to `.env` and add appropriate values for the variables
- You'll need a local copy of the cross-partner spreadsheet, which can be obtained by exporting to csv. Be careful: if you try to open this file on a Mac, your computer will try to convert it to a Numbers file, which will give you useless garbage.
- Run `ruby main.rb` from root directory.

The app will display a list of customer codes that differ between NYPL and the partners, the diff for each code, as well as lists of codes that only we have or only our partners have.
