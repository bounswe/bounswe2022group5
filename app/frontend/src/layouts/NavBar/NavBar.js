import React, { useState, useEffect } from "react";
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
            <Button style={buttonStyle} type="primary" className="logout-button" onClick={() => {onLogout(dispatch) ; navigate("/")}}>
                <CloseCircleOutlined />
                Log Out
            </Button>
            </div>
        )
    }
}


const NavBar = ({query}) => {
    const {status: userStatus } = useSelector((state) => state.user);
    const navigate = useNavigate();
    const [searchInput, setSearchInput] = useState(query);

    useEffect(() => {
        var input = document.getElementById("search-input");

        // Execute a function when the user presses a key on the keyboard
        input.addEventListener("keypress", function(event) {
          // If the user presses the "Enter" key on the keyboard
          if (event.key === "Enter") {
            // Cancel the default action, if needed
            event.preventDefault();
            // Trigger the button element with a click
            document.getElementById("search-submit").click();
          }
        });
    }, []);

    return (
        <div className="nav-bar"> 
                
            <div className="logo" onClick={() => navigate("/")}>
                <Image src={logo} preview={false}/>
            </div>
            <div className="search-bar">
                <Input 
                    id="search-input"
                    style={searchBarStyle}
                    placeholder="Search in Website" 
                    value={searchInput}
                    onChange={(e) => setSearchInput(e.target.value)}
                />
                <Button style={buttonStyle} type="primary" id="search-submit" onClick={() => {
                    if(searchInput) {
                        navigate(`/search/${searchInput}`)
                    } else {
                        navigate(`/`)
                    }
                }}>
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