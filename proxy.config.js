module.exports = {
    "/api": {
        target: "http://localhost:5000/",
        secure: true,
        changeOrigin: true,
        logLevel: "debug"
    },
    "/connect": {
        target: "http://localhost:5000/", 
        secure: true,
        changeOrigin: true,
        logLevel: "debug"
    }
};
