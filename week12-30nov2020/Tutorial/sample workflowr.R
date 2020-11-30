# Introduction:
# * Effective project management
# 
# * Collaboration
# 
# * Reproducibility


# Workflowr
# * Literate programming (knitr and rmarkdown)
# 
# * Version control (git)
# 
# * Combining them to generate a website containing time-stamped, versioned, and documented results

# Example

# * An example of the generated website in this [link](https://stephenslab.github.io/wflow-divvy/)




library("workflowr")

# Configure Git (only need to do once per computer)
wflow_git_config(user.name = "ahmadrezauf", user.email = "ahmadrezauf@gmail.com", overwrite = TRUE)

# It asks you for your username and password for pushing to the repo
# Making it easier to access the Github
# brew install libssh2
# devtools::install_github("ropensci/git2r")
# It doesn't work for ssh though! Use the following procedure
# brew install libssh2
# brew install libgit2
# install.packages("git2r", type="source", configure.vars="autobrew=yes")
# git2r::libgit2_features()
library(git2r)

setwd("./myproject/")
wflow_git_remote(remote = "origin", user = "ahmadrezauf", repo = "myproject",
                 protocol = "ssh", action = "set_url")

# Start a new workflowr project
wflow_start("myproject", git = TRUE)
# Initiates the infrastructure
# Creates several sudirectories
# |--- .gitignore
# |--- .Rprofile
# |--- _workflowr.yml
# |--- analysis/
#   |   |--- about.Rmd
# |   |--- index.Rmd
# |   |--- license.Rmd
# |   |--- _site.yml
# |--- code/
#   |   |--- README.md
# |--- data/
#   |   |--- README.md
# |--- docs/
#   |--- <directory>.Rproj
# |--- output/
#   |   |--- README.md
# |--- README.md


# Analysis folder:
# contains all the R Markdown files that implement the analyses for your project
# Includes index.Rmd for generating index.html
# _site.yml : a YAML file describing your website, rmarkdown’s site generator
# YAML: human-readable data-serialization language
# See the example
# 
# Famous icons in Font Awesome, Ionicons, Bootstrap Glyphicons
# When referring to an icon, you should use its full name including the icon set prefix
# (e.g., fa-github, ion-social-twitter, and glyphicon-time

# Can also define a html file instead of the yml as well: _navbar.html
# 

# Rendered HTML files will go into docs folder

# data, code, and output are made for you!

# code could be used for preprocessing, long-running scripts, 
# or functions that are used in multiple R Markdown files

# All subdirectories containt a README file summarizing the contents of the subdirectory

# Viewing the site index.html:
wflow_view()

# Build the site
wflow_build()


# Get the status
wflow_status()


# Preview your changes
wflow_build()

# Publish the site, i.e. version the source code and HTML results
wflow_publish("analysis/*", "Start my new project")



# Working with Github
wflow_use_github("ahmadrezauf")

# Dry run shows you what the function will do:
wflow_git_push(dry_run = TRUE)
wflow_git_push()

# How to tell Github that you want the files in the docs folder to be published as a website
# Setting -> Github pages -> souce: branch:master -> select folder: docs
# https://ahmadrezauf.github.io/myproject/


# Creating and opening a new analysis file
wflow_open("analysis/first-analysis.Rmd")

# Let's add stuff to index.RMD
# Some histogram from the first-analysis.Rmd was added to it.
# Remember the sessioninfo


wflow_status()
wflow_publish(c("analysis/index.Rmd", "analysis/first-analysis.Rmd"),
              "Add my first analysis")
# Can you guess how can we push the changes?

wflow_git_push()

# republish every html file?
# needed after editting _site.yml
wflow_publish("analysis/*", "Start my new project")


# Adding CSS files
# Copy your CSS file to the analysis folder
wflow_build(make = TRUE)
wflow_publish(c("analysis/_site.yml", "analysis/style.css"),
              message = "Customize website style.",
              republish = TRUE)

# Include an image
dir.create("docs/assets")
wflow_open("analysis/second-analysis.Rmd")
wflow_build()
wflow_publish(c("analysis/index.Rmd", "analysis/second-analysis.Rmd"),
              "Add my first analysis")
wflow_git_commit(all = TRUE) 


# Using large data files with workflowr
# You can find previous version of your analysis in workflowr
# But what if you were using large files?

# The max file size that is ok to push to Git is 100 MB

# Option 0:
# Large raw data files do not need to be versioned! for example FASTQ files
# 1- Upload the files to an online data repository, a private FTP server, etc.
# 2- Add a script to your workflowr project that can download all the files
# 3- Include the instructions in your README and your workflowr website that explain how to download the files
# For example, upload them to GEO/SRA

# Option 1:
# Record meta data about your changes
# modification date, file size, MD5 checksum, number of rows, number of columns, column means, etc

# Option 2:
# Use GitLFS


# Option 3:
# If you don't like using GitLFS, there is an R package: piggyback
# You should tune it with Git
# This option is recommended if you anticipate substantial, but infrequent, changes to your large data files.
# Works for data up to 2 GB

# Option 4:
# Use a database 
# Query for your required data!


# What other vignettes can you find?

# Migrating an existing project to use workflowr
# Sharing common code across analyses
# Hosting workflowr websites using GitLab
# etc
