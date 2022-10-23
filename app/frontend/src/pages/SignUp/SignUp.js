import React, { useState } from "react";
import ReactCardFlip from 'react-card-flip';
import { LockOutlined, UserOutlined } from '@ant-design/icons';
import { Button, Form, Input } from 'antd';
import Switch from "react-switch";
import { FaStethoscope } from 'react-icons/fa';

import "./SignUp.css";

const SignUp = () => {
    const [flipped, setFlipped] = useState(false);
    const [userForm] = Form.useForm();

    const [username, setUsername] = useState();
    const [email, setEmail] = useState();
    const [password, setPassword] = useState();
    const [passwordConfirm, setPasswordConfirm] = useState();
    const [firstName, setFirstName] = useState();
    const [lastName, setLastName] = useState();
    const [phoneNumber, setPhoneNumber] = useState();
    const [country, setCountry] = useState();
    const [city, setCity] = useState();
    const [title, setTitle] = useState();
    const [branch, setBranch] = useState();

    const handleClick = () => {
        setFlipped(!flipped);
    }

    const onFinish = (values) => {
        console.log('Finish:', values);
    };

    const iconStyle = {
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
        height: "100%",
        fontSize: 20
      }

    return(
        <div className="signup-background">

            {/* <div className="navbar">
                <a href="/" >LOGO</a>
            </div> */}

            <ReactCardFlip isFlipped={flipped} flipDirection="horizontal" className="card-flip">

                <div className="signup-user-container">
                    <Switch
                        checked={flipped}
                        onChange={handleClick}
                        onColor="#ffffff"
                        offColor="#ffffff"
                        onHandleColor="#00d3ff"
                        offHandleColor="#00d3ff"
                        handleDiameter={35}
                        checkedIcon={<div style={iconStyle}><UserOutlined className="site-form-item-icon" /></div>}
                        uncheckedIcon={<div style={iconStyle}><FaStethoscope /></div>}
                        checkedHandleIcon={<div style={iconStyle}><FaStethoscope /></div>}
                        uncheckedHandleIcon={<div style={iconStyle}><UserOutlined className="site-form-item-icon" /></div>}
                        height={30}
                        width={100}
                        className="switch"
                        id="material-switch"
                    />
                    <h1 className="title">User Membership</h1>

                    <Form 
                        form={userForm} 
                        onFinish={onFinish} 
                        className="form"
                        // initialValues={{ remember: true }}
                    >
                        <div className="input-inline">
                            <div className="label-input">
                                <span>*Username:</span>
                                <Form.Item
                                    name="Username"
                                    rules={[{ required: true, message: 'Please input your username!' }]}
                                >
                                    <Input 
                                        prefix={<UserOutlined className="site-form-item-icon" />} 
                                        placeholder="Username" 
                                        value={username}
                                        onChange={(e) => setUsername(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>*Email:</span>
                                <Form.Item
                                    name="Email"
                                    rules={[{ required: true, message: 'Please input your email!' }]}
                                >
                                    <Input 
                                        placeholder="Email" 
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>
                        <div className="input-inline">
                            <div className="label-input">
                                <span>*Password:</span>
                                <Form.Item
                                    name="password"
                                    rules={[{ required: true, message: 'Please input your password!' }]}
                                >
                                    <Input
                                        type="password"
                                        prefix={<LockOutlined className="site-form-item-icon" />}
                                        placeholder="Password"
                                        className="input-box"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>*Password Confirm:</span>
                                <Form.Item
                                    name="confirm"
                                    dependencies={['password']}
                                    rules={[
                                    {
                                        required: true,
                                        message: 'Please confirm your password!',
                                    },
                                    ({ getFieldValue }) => ({
                                        validator(_, value) {
                                        if (!value || getFieldValue('password') === value) {
                                            return Promise.resolve();
                                        }
                                        return Promise.reject(new Error('The two passwords must match!'));
                                        },
                                    }),
                                    ]}
                                >
                                    <Input
                                        prefix={<LockOutlined className="site-form-item-icon" />}
                                        type="password"
                                        placeholder="Password Confirm"
                                        className="input-box"
                                        value={passwordConfirm}
                                        onChange={(e) => setPasswordConfirm(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <div className="input-inline">
                            <div className="label-input">
                                <span>First Name:</span>
                                <Form.Item
                                    name="firstName"
                                >
                                    <Input 
                                        placeholder="First Name (Optional)" 
                                        value={firstName}
                                        onChange={(e) => setFirstName(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>Last Name:</span>
                                <Form.Item
                                    name="lastName"
                                >
                                    <Input 
                                        placeholder="Last Name (Optional)" 
                                        value={lastName}
                                        onChange={(e) => setLastName(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <Form.Item >
                            <Button type="primary" htmlType="submit" className="input-box">
                                Sign Up
                            </Button>
                            <div>
                                Or <a href="/login">sign in now!</a>
                            </div>
                        </Form.Item>
                    </Form>
                </div>
                <div className="signup-doctor-container">
                    <Switch
                        checked={flipped}
                        onChange={handleClick}
                        onColor="#ffffff"
                        offColor="#ffffff"
                        onHandleColor="#00d3ff"
                        offHandleColor="#00d3ff"
                        handleDiameter={35}
                        checkedIcon={<div style={iconStyle}><UserOutlined className="site-form-item-icon" /></div>}
                        uncheckedIcon={<div style={iconStyle}><FaStethoscope /></div>}
                        checkedHandleIcon={<div style={iconStyle}><FaStethoscope /></div>}
                        uncheckedHandleIcon={<div style={iconStyle}><UserOutlined className="site-form-item-icon" /></div>}
                        height={30}
                        width={100}
                        className="switch"
                        id="material-switch"
                    />
                    <h1 className="title">Doctor Membership</h1>

                    <Form 
                        form={userForm} 
                        onFinish={onFinish} 
                        className="form"
                    >
                        <div className="input-inline">
                            <div className="label-input">
                                <span>*First Name:</span>
                                <Form.Item
                                    name="First Name"
                                    rules={[{ required: true, message: 'Please input your first name!' }]}
                                >
                                    <Input 
                                        prefix={<UserOutlined className="site-form-item-icon" />} 
                                        placeholder="First Name" 
                                        value={firstName}
                                        onChange={(e) => setFirstName(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>*Last Name:</span>
                                <Form.Item
                                    name="Last Name"
                                    rules={[{ required: true, message: 'Please input your last name!' }]}
                                >
                                    <Input 
                                        prefix={<UserOutlined className="site-form-item-icon" />} 
                                        placeholder="Last Name" 
                                        value={lastName}
                                        onChange={(e) => setLastName(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <div className="input-inline">
                            <div className="label-input">
                                <span>*Email:</span>
                                <Form.Item
                                    name="Email"
                                    rules={[{ required: true, message: 'Please input your email!' }]}
                                >
                                    <Input 
                                        placeholder="Email" 
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>*Phone Number:</span>
                                <Form.Item
                                    name="Phone Number"
                                    rules={[{ required: true, message: 'Please input your phone number!' }]}
                                >
                                    <Input 
                                        placeholder="Phone Number" 
                                        value={phoneNumber}
                                        onChange={(e) => setPhoneNumber(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <div className="input-inline">
                            <div className="label-input">
                                <span>*Password:</span>
                                <Form.Item
                                    name="password"
                                    rules={[{ required: true, message: 'Please input your password!' }]}
                                >
                                    <Input
                                        type="password"
                                        prefix={<LockOutlined className="site-form-item-icon" />}
                                        placeholder="Password"
                                        className="input-box"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>*Password Confirm:</span>
                                <Form.Item
                                    name="confirm"
                                    dependencies={['password']}
                                    rules={[
                                    {
                                        required: true,
                                        message: 'Please confirm your password!',
                                    },
                                    ({ getFieldValue }) => ({
                                        validator(_, value) {
                                        if (!value || getFieldValue('password') === value) {
                                            return Promise.resolve();
                                        }
                                        return Promise.reject(new Error('The two passwords must match!'));
                                        },
                                    }),
                                    ]}
                                >
                                    <Input
                                        prefix={<LockOutlined className="site-form-item-icon" />}
                                        type="password"
                                        placeholder="Password Confirm"
                                        className="input-box"
                                        value={passwordConfirm}
                                        onChange={(e) => setPasswordConfirm(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <div className="input-inline">
                            <div className="label-input">
                                <span>Country:</span>
                                <Form.Item
                                    name="country"
                                >
                                    <Input 
                                        placeholder="Country" 
                                        value={country}
                                        onChange={(e) => setCountry(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>City:</span>
                                <Form.Item
                                    name="city"
                                >
                                    <Input 
                                        placeholder="City" 
                                        value={city}
                                        onChange={(e) => setCity(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <div className="input-inline">
                            <div className="label-input">
                                <span>*Title:</span>
                                <Form.Item
                                    name="title"
                                    rules={[{ required: true, message: 'Please input your title!' }]}
                                >
                                    <Input 
                                        placeholder="Title" 
                                        value={title}
                                        onChange={(e) => setTitle(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                            <div className="label-input">
                                <span>*Branch:</span>
                                <Form.Item
                                    name="branch"
                                    rules={[{ required: true, message: 'Please input your branch!' }]}
                                >
                                    <Input 
                                        placeholder="Branch" 
                                        value={branch}
                                        onChange={(e) => setBranch(e.target.value)}
                                    />
                                </Form.Item>
                            </div>
                        </div>

                        <Form.Item >
                            <Button type="primary" htmlType="submit" className="input-box">
                                Sign Up
                            </Button>
                            <div>
                                Or <a href="/login">sign in now!</a>
                            </div>
                        </Form.Item>
                    </Form>
                </div>
            </ReactCardFlip>
        </div>
    );
};

export default SignUp;