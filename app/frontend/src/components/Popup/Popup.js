import { Button } from "antd";
import React from "react";
import './Popup.css'

const editButton = {
    width: "10%",
    borderRadius: 50,
    borderColor:'rgba(0,0,0,0.5)',
    backgroundColor: 'rgb(255,255,255)',
    color: 'rgb(104,172,252)',
}

function Popup(props) {
    return (props.trigger) ? (
        <div className="popup">
            <div className="popup-inner">
                <Button className="close-btn" style={editButton} onClick={() => props.setTrigger(false)}>
                    Close
                </Button>
                {props.children}
            </div>
        </div>
    ) : "";
}

export default Popup;

