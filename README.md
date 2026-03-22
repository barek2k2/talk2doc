# AI-Powered PDF Q&A App

This Ruby on Rails application allows users to upload PDF documents and ask questions about their content.

The system uses **Retrieval-Augmented Generation (RAG)** along with a **local Large Language Model (LLM)** to generate intelligent answers based on the uploaded PDF. To protect data privacy, all PDF processing happens locally, and no document data is sent to any external AI service.

## Prerequisites

Before running this application, make sure the following dependencies are installed and configured:

- **PostgreSQL** with vector database support enabled (such as the `pgvector` extension)
- **Ollama** installed on your machine
- At least one(`gemma2:9b`) **local LLM** installed and available through Ollama

## Features

- Upload PDF documents
- Ask questions about uploaded PDFs
- Intelligent answers using RAG
- Local LLM integration through Ollama
- Privacy-focused local processing
- No document data uploaded to online AI services
- No API key is needed! No token limitations!

## Privacy

This application is designed with privacy in mind. All document processing and question answering are performed locally, helping ensure that sensitive PDF data stays on your system.