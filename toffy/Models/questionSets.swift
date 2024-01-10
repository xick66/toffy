//
//  questionSets.swift
//  toffy
//
//  Created by Rahul K M on 01/01/24.
//
import Foundation

let questionSets = [
    // Set A
    [
        AppQuestion(id: 1, text: "How did your morning begin?", options: ["Exercise", "Checking emails", "Hearty breakfast", "Sleeping in"], sentimentScores: [2, 3, 2, 4]),
        AppQuestion(id: 2, text: "What was today's main achievement?", options: ["Work project", "Meeting with friends", "Relaxing", "Learning new things"], sentimentScores: [3, 2, 2, 2]),
        AppQuestion(id: 3, text: "How did you feel today mostly?", options: ["Productive", "Relaxed", "Stressed", "Engaged"], sentimentScores: [2, 2, 4, 2]),
        AppQuestion(id: 4, text: "What did you do to relax after work?", options: ["Watch TV", "Read", "Family time", "Exercise"], sentimentScores: [3, 3, 2, 2]),
        AppQuestion(id: 5, text: "Which activity did you enjoy most?", options: ["Morning routine", "Conversation", "Eating a meal", "Completing tasks"], sentimentScores: [2, 2, 2, 2])
    ],
    // Set B
    [
        AppQuestion(id: 1, text: "What kick-started your day today?", options: ["A brisk walk", "Reading news", "A cup of coffee", "Extra sleep"], sentimentScores: [2, 3, 3, 4]),
        AppQuestion(id: 2, text: "What was a key task you accomplished?", options: ["Attending meetings", "Catching up with friends", "Personal time", "Exploring a hobby"], sentimentScores: [3, 2, 3, 2]),
        AppQuestion(id: 3, text: "Overall, how was your mood?", options: ["Energetic", "Peaceful", "Under pressure", "Inquisitive"], sentimentScores: [2, 2, 4, 3]),
        AppQuestion(id: 4, text: "How did you unwind this evening?", options: ["Binge-watching a show", "Enjoying a book", "Quality time with family", "Working out"], sentimentScores: [3, 3, 2, 2]),
        AppQuestion(id: 5, text: "What was the most enjoyable part of your day?", options: ["Morning exercise", "Chatting with someone", "Savoring food", "Accomplishing a goal"], sentimentScores: [2, 2, 2, 2])
    ],
    // Set C
    [
        AppQuestion(id: 1, text: "How did you get your day started?", options: ["Jogging", "Meditation", "Breakfast with family", "Snoozing alarm"], sentimentScores: [2, 2, 2, 4]),
        AppQuestion(id: 2, text: "What was a significant achievement today?", options: ["Finishing work tasks", "Socializing", "Taking time to relax", "Learning a skill"], sentimentScores: [3, 2, 3, 2]),
        AppQuestion(id: 3, text: "What was your predominant feeling today?", options: ["Motivated", "Content", "Anxious", "Curious"], sentimentScores: [2, 2, 4, 2]),
        AppQuestion(id: 4, text: "Your preferred method to de-stress tonight?", options: ["Watching a movie", "Reading", "Dinner with family", "Hitting the gym"], sentimentScores: [3, 3, 2, 2]),
        AppQuestion(id: 5, text: "What part of your day did you find most fulfilling?", options: ["Early morning workout", "Deep conversations", "Delicious meals", "Completing tasks"], sentimentScores: [2, 2, 2, 2])
    ],
    // Set D
    [
        AppQuestion(id: 1, text: "What activity initiated your day?", options: ["Cycling", "Browsing social media", "Cooking breakfast", "Lying in bed"], sentimentScores: [2, 3, 2, 4]),
        AppQuestion(id: 2, text: "Your major accomplishment for the day?", options: ["Professional tasks", "Meeting new people", "Leisure time", "Acquiring new information"], sentimentScores: [3, 2, 3, 2]),
        AppQuestion(id: 3, text: "Describe your mood throughout the day.", options: ["Dynamic", "Tranquil", "Stressed out", "Thoughtful"], sentimentScores: [2, 2, 4, 3]),
        AppQuestion(id: 4, text: "How did you spend your post-work hours?", options: ["TV series", "Indulging in a novel", "Chatting with family", "Physical training"], sentimentScores: [3, 3, 2, 2]),
        AppQuestion(id: 5, text: "Which part of the day did you relish the most?", options: ["Morning regime", "Interactions", "Meal times", "Achieving goals"], sentimentScores: [2, 2, 2, 2])
    ],
    // Set E
    [
        AppQuestion(id: 1, text: "What started off your morning?", options: ["Yoga", "Emails", "Breakfast with loved ones", "Staying in bed longer"], sentimentScores: [2, 3, 2, 4]),
        AppQuestion(id: 2, text: "What's a notable thing you did today?", options: ["Work-related success", "Spending time with friends", "Resting", "Picking up a new skill"], sentimentScores: [3, 2, 4, 2]),
        AppQuestion(id: 3, text: "How would you summarize your feelings today?", options: ["Driven", "Calm", "Overwhelmed", "Intrigued"], sentimentScores: [2, 2, 4, 3]),
        AppQuestion(id: 4, text: "Your evening relaxation routine?", options: ["Streaming a series", "Losing yourself in a book", "Family time", "Gym session"], sentimentScores: [3, 3, 2, 2]),
        AppQuestion(id: 5, text: "What moment stood out for you today?", options: ["Morning fitness", "Heartfelt talks", "Enjoying food", "Task completion"], sentimentScores: [2, 2, 2, 2])
    ],
    // Set F
    [
        AppQuestion(id: 1, text: "What was the first thing you did this morning?", options: ["Working out", "Scrolling through news", "Having breakfast", "Lazing around"], sentimentScores: [2, 3, 2, 4]),
        AppQuestion(id: 2, text: "What's a significant thing you achieved today?", options: ["Completing work", "Social interactions", "Time for self", "Gaining knowledge"], sentimentScores: [3, 2, 3, 2]),
        AppQuestion(id: 3, text: "What was your general state of mind?", options: ["Active", "Relaxed", "Pressured", "Engrossed"], sentimentScores: [2, 2, 4, 3]),
        AppQuestion(id: 4, text: "How did you chill today?", options: ["Played with friends", "Went out", "Binge watch and snacking", "Didn't chill"], sentimentScores: [2, 2, 3, 5])
    ]
]

    struct AppQuestion: Identifiable {
        let id: Int
        let text: String
        let options: [String]
        let sentimentScores: [Int]
    }

