// const functions = require('firebase-functions');
// 
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

'use strict';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
// admin.initializeApp();
// const promisePool = require('es6-promise-pool');
// const PromisePool = promisePool.PromisePool;
// Maximum concurrent account deletions.
// const MAX_CONCURRENT = 3;

admin.initializeApp(functions.config().firebase);

let db = admin.firestore();

/**
 * Run once a day at midnight, to cleanup the users
 * Manually run the task here https://console.cloud.google.com/cloudscheduler
 */
exports.sendNotifications = functions.pubsub.schedule('every 15 minutes').onRun(async context => {
    // Fetch all user details.
    let screenings = await getScreenings();

   // This registration token comes from the client FCM SDKs.
    // var registrationToken = 'YOUR_REGISTRATION_TOKEN';

    // var message = {
    // data: {
    //     score: '850',
    //     time: '2:45'
    // },
    // token: registrationToken
    // };

    // Send a message to the device corresponding to the provided
    // registration token.
    // admin.messaging().send(message)
    // .then((response) => {
    //     // Response is a message ID string.
    //     console.log('Successfully sent message:', response);
    // })
    // .catch((error) => {
    //     console.log('Error sending message:', error);
    // });
});

async function getScreenings(users = [], nextPageToken) {
    db.collection('screenings').get()
    .then((snapshot) => {
        return getNotifications(snapshot);
    })
    .catch((err) => {
        console.log('Error getting documents', err);
    }); 
}

/**
 * Returns the list of all inactive users.
 */
async function getNotifications(screeningData, users = [], nextPageToken) {
    var info = [];

    const today = new Date()

    db.collection('users').get()
    .then((snapshot) => {
        snapshot.forEach((doc) => {
            const user = doc.data();
            screeningData.forEach((screeningDocument) => {
                var screening = screeningDocument._fieldsProto;
                if (user.sex === screening.sex.stringValue) {
                    switch(screening.name.stringValue) {
                        case "Blood Pressure":
                            var lastScreening = user.lastBloodPressureScreening.toDate();
                            var timeSinceLastScreen = Math.floor((today - lastScreening) / (1000*60*60*24));
                            // if (timeSinceLastScreen >= (365 * screening.interval)) {
                            //     info.append({ registrationToken: user.registrationToken, message: screening.message })
                            // }
                            break;
                        case "Prostate":
                            var age = Date() - user.birthdate.toDate();
                            var olderThan40 = age >= screening.minAge.integerValue;
                            lastScreening = user.lastProstateScreening.toDate();
                            timeSinceLastScreen = Math.floor((today - lastScreening) / (1000 * 60 * 60 * 24));
                            break;
                        case "Influenza":
                            age = Date() - user.birthdate.toDate();
                            var seventeenOrOlder = age >= screening.minAge.integerValue;
                            lastScreening = user.lastInfluenzaScreening.toDate()
                            timeSinceLastScreen = Math.floor((today - lastScreening) / (1000 * 60 * 60 * 24));
                            break;
                        default:
                            console.log("Default Case")
                            break;
                    }
                }
            });
        });
        return snapshot.value
    })
    .catch((err) => {
        console.log('Error getting documents', err);
    });  
}