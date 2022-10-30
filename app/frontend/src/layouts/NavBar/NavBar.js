import React, { useState } from "react";
import {NotificationOutlined, UserOutlined, UserAddOutlined, CloseCircleOutlined } from '@ant-design/icons';
import { Button, Input} from 'antd';
import { useSelector, useDispatch } from 'react-redux';
import { LogOut } from "../../redux/userSlice"

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
    dispatch(LogOut());
};

const LogInLogOut = ({userStatus}) => {
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
            <Button style={buttonStyle} type="primary" className="logout-button" onClick={() => onLogout(dispatch)}>
                <CloseCircleOutlined />
                Log Out
            </Button>
        )
    }
}


const NavBar = () => {
    const {status: userStatus } = useSelector((state) => state.user);

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