const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    fullname:{
        type:String,
        required:true
    },
    dob:{
        type:String,
        required:false
    },
    pob:{
        type:String,
        required:false
    },
    height:{
        type:String,
        required:false
    },
    weight:{
        type:String,
        required:false
    },
    marital_status:{
        type:String,
        enum:['Single','Widowed','Divorced']
    },
    state:{
        type:String,
    },
    city:{
        type:String
    },
    address:{
        type:String
    },
    religion:{
        type:String
    },
    caste:{
        type:String
    },
    subcaste:{
        type:String
    },
    mother_tongue:{
        type:String,
    },
    gender:{
        type:String,
        enum:['Male','Female','Others']
    },
    education:{
        type:String
    },
    occupation:{
        type:String
    },
    worksWith:{
        type:String
    },
    workAS:{
        type:String
    },
    annual_income:{
        type:Number
    },
    diet:{
        type:String,
        enum: ['Veg','Non-Veg']
    },
    family_type:{
        type:String,
        enum:['Joint','Nuclear']
    },
    image:{
        type:String,
    },
    phone:{
        type:Number
    },

    email:{
        type:String,
        required:true,
        validate:{
            validator:(value)=>{
                const regex = /[a-z0-9\._%+!$&*=^|~#%'`?{}/\-]+@([a-z0-9\-]+\.){1,}([a-z]{2,16})/;
                return regex.test(value);
            }
        }
    },
    password:{
        type:String,
        required:true
    }
});

const User = mongoose.model('User',userSchema);
module.exports = User;