import React, { useState } from "react";
import { useNavigate } from 'react-router-dom';
import { useDispatch } from 'react-redux';
import { LockOutlined, UserOutlined } from '@ant-design/icons';
import { Button, Checkbox, Form, Input, notification } from 'antd';
import { fetchLogin, login, fetchMe } from "../../redux/userSlice";

import "./Login.css";

const Login = () => {
    const dispatch = useDispatch();
    const navigate = useNavigate();

    const [form] = Form.useForm();

    const [email, setEmail] = useState("");
    const [password, setPassword] = useState("");

    const onFinish = (values) => {
        const isEmail = values?.email.match(/^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/)
        const body = isEmail ? { ...values, email: values?.email } : { ...values, username: values?.email }

        fetchLogin(body)
            .then((res) => {
                notification["success"]({
                    message: 'Login is successful',
                    placement: "top"
                });

                dispatch(login({ ...res.data?.data, token: res.data?.token }));
                dispatch(fetchMe(res.data?.token));
                navigate("/")
            })
            .catch((err) => {
                notification["error"]({
                    message: "Login is not successful",
                    description: err?.message,
                    placement: "top"
                });
            })
    };

    return(
        <div className="login-background">

            <div className="navbar">
                <a href="/" className="logo"><h1>LOGO</h1></a>
            </div>

            <div className="login-container">
                <h1 className="title">Login</h1>

                <Form 
                    form={form} 
                    layout="inline" 
                    onFinish={onFinish} 
                    className="form"
                    initialValues={{ remember: true }}
                >
                    <Form.Item
                        name="email"
                        rules={[{ required: true, message: 'Please input your email!' }]}
                    >
                        <Input 
                            prefix={<UserOutlined className="site-form-item-icon" />} 
                            placeholder="Email / Username" 
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                        />
                    </Form.Item>
                    <Form.Item
                        name="password"
                        rules={[{ required: true, message: 'Please input your password!' }]}
                    >
                        <Input
                            prefix={<LockOutlined className="site-form-item-icon" />}
                            type="password"
                            placeholder="Password"
                            className="input-box"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                        />
                    </Form.Item>

                    <Form.Item >
                        <Button type="primary" htmlType="submit" className="input-box">
                            Log in
                        </Button>
                        <div>
                            Or <a href="/signup">register now!</a>
                        </div>
                    </Form.Item>
                </Form>
            </div>
        </div>
    );
};

export default Login;