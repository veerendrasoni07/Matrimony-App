const express = require('express');
const bannerRoute = express.Router();
const Banner = require('../model/banner');
bannerRoute.post('/api/upload-banner',async(req,res)=>{
    try {
        const {banner} = req.body;
        const newBanner = new Banner(
            banner
        );
        newBanner = await newBanner.save();
        res.status(200).json("newBanner");
    } catch (error) {
        
    }
})