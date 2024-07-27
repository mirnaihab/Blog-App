# Blog Application

## Overview
This project is a Blog Application that provides a RESTful API for managing users and blog posts. The application includes user authentication, post creation and management, and comment functionality. The backend is built with Ruby on Rails, and the application uses PostgreSQL for the database, Sidekiq and Redis for background job processing, and Docker for containerization.

## Features

### User Authentication

Sign Up: Users can create an account with a name, email, password, and an optional image.
Log In: Users can log in using their email and password.
JWT Authentication: The application uses JWT (JSON Web Tokens) for secure API authentication.
Protected Endpoints: All API endpoints, except for login and signup, require authentication.

### Posts Management

Create, Read, Update, Delete (CRUD): Users can create, view, edit, and delete posts.
Post Attributes: Each post includes a title, body, author, tags, and comments.
Author: The author of a post is a user entity.
Permissions: Users can only edit or delete their own posts and comments.
Tags: Users can add and update tags for their posts. Each post must have at least one tag.
Auto-Deletion: Posts are automatically deleted 24 hours after creation.

### Video Demonstration

A video demonstration of the application can be found here. 
https://drive.google.com/drive/folders/1XsDu2v1dIYTnTvSyIDPcXWjoWIh_3-9z?usp=sharing

### Technologies Used

Backend: Ruby on Rails
Database: PostgreSQL
Background Jobs: Sidekiq
In-Memory Data Store: Redis
Authentication: JWT
Containerization: Docker, Docker Compose
### Setup
To run the application, use Docker Compose: docker-compose up and test APIs on postman at URL: http://0.0.0.0:3000


