import React, { useState } from "react";
import {NotificationOutlined, UserOutlined, UserAddOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { Button, Input, Image} from 'antd';
import { useSelector, useDispatch } from 'react-redux';
import { useNavigate } from "react-router-dom";
import { logOut } from "../../redux/userSlice"
import logo from './logo.png';

import "./NavBar.css";

const buttonStyle = {
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(104,172,252)',
  }

const searchBarStyle = {
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    fontSize: 14,
    backgroundColor: 'rgba(230,230,230)',
}

const onLogout = (dispatch) => {
    dispatch(logOut());
};

const LogInLogOut = ({userStatus}) => {
    const navigate = useNavigate();
    const dispatch = useDispatch();

    if (userStatus !== "fulfilled") {
        return (
            <div className="signup-login-buttons">
            <Button style={buttonStyle} type="primary" href="/signup">
                <UserAddOutlined />
                Sign Up
            </Button>
            <Button style={buttonStyle} type="primary" href="/login">
                <UserOutlined />
                Log In
            </Button>
        </div>
        )
    } else {
        return (
            <div>
            <Button style={buttonStyle} type="primary" className="logout-button" onClick={() => navigate("/profile") }>
            <UserOutlined />
            Profile Page
            </Button>
            <Button style={buttonStyle} type="primary" className="logout-button" onClick={() => onLogout(dispatch)}>
                <CloseCircleOutlined />
                Log Out
            </Button>
            </div>
        )
    }
}


const NavBar = () => {
    const {status: userStatus } = useSelector((state) => state.user);

    const [searchInput, setSearchInput] = useState("");
    const navigate = useNavigate();

    return (
        <div className="nav-bar">
            <div className="logo">
                
                <Image src={logo} preview={false} onClick={()=> navigate("/")}/>   
                
            </div>
            <div className="search-bar">
                <Input 
                    style={searchBarStyle}
                    placeholder="Search in Website" 
                    value={searchInput}
                    onChange={(e) => setSearchInput(e.target.value)}
                />
                <Button style={buttonStyle} type="primary">
                    Search
                </Button>
            </div>
            <LogInLogOut userStatus={userStatus}/>
        </div>
    )
}

export default NavBar

/*
            <Button style={buttonStyle} type="primary" hidden={userStatus === "idle"}>
                <NotificationOutlined/>
            </Button>
*/