import React, { useState } from "react";
import {NotificationOutlined, UserOutlined, UserAddOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { Button, Form, Input} from 'antd';
import { useSelector } from 'react-redux';

import "./NavBar.css";

const BASE_URL = "http://localhost:3000"        // To do: This line should be removed from here to a more general place.
const LOGIN_PAGE = `${BASE_URL}/login`
const SIGNUP_PAGE = `${BASE_URL}/signup`

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

const onLogout = (values) => {
    // This should contain logout function.
};

const LogInLogOut = ({userStatus}) => {
    if (userStatus === "idle") {
        return (
            <div className="signup-login-buttons">
            <Button style={buttonStyle} type="primary" href={SIGNUP_PAGE}>
                <UserAddOutlined />
                Sign Up
            </Button>
            <Button style={buttonStyle} type="primary" href={LOGIN_PAGE}>
                <UserOutlined />
                Log In
            </Button>
        </div>
        )
    } else {
        return (
            <Button style={buttonStyle} type="primary" className="logout-button" onClick={onLogout}>
                <CloseCircleOutlined />
                Log Out
            </Button>
        )
    }
}


const NavBar = () => {
    const {status: userStatus } = useSelector((state) => state.user);
    const [form] = Form.useForm();

    const [searchInput, setSearchInput] = useState("");

    return (
        <div className="nav-bar">
            <Button className="logo" shape="round" style={buttonStyle}>
                Logo
            </Button>
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
            <Button style={buttonStyle} type="primary" hidden={userStatus === "idle"}>
                <NotificationOutlined/>
            </Button>
            <LogInLogOut userStatus={userStatus}/>
        </div>
    )
}

export default NavBar