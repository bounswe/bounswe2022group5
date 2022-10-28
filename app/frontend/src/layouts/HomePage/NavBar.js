import React, { useState } from "react";
import {NotificationOutlined, UserOutlined, UserAddOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { Button, Form, Input} from 'antd';

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

const LogInLogOut = ({isLoggedIn}) => {
    if (!isLoggedIn) {
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
            <Button style={buttonStyle} type="primary" className="logout-button" href={BASE_URL}>
                <CloseCircleOutlined />
                Log Out
            </Button>
        )
    }
}

const NavBar = () => {
    const isLoggedIn = false

    // const { status: userStatus } = useSelector((state) => state.user);
    // Since redux is not implemented. This code block will be replaced as "isLoggedIn".

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
            <Button style={buttonStyle} type="primary" hidden={!isLoggedIn}>
                <NotificationOutlined/>
            </Button>
            <LogInLogOut isLoggedIn={isLoggedIn}/>
        </div>
    )
}

export default NavBar