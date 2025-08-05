import React from "react";
import "./App.css";

function App() {
  const officeList = [
    { Name: "DBS", Rent: 50000, Address: "Chennai" },
    { Name: "WeWork", Rent: 75000, Address: "Mumbai" },
    { Name: "Regus", Rent: 58000, Address: "Bangalore" },
  ];

  return (
    <div
      className="App"
      style={{
        backgroundColor: "#f7f7f7",
        minHeight: "100vh",
        padding: "20px",
      }}
    >
      <h1
        style={{
          color: "#2c3e50",
          fontFamily: "Arial, sans-serif",
          textAlign: "center",
        }}
      >
        Office Space - Affordable Range
      </h1>

      <div style={{ textAlign: "center", margin: "20px 0" }}>
        <img
          src="https://images.unsplash.com/photo-1520607162513-77705c0f0d4a?w=1000"
          width="40%"
          style={{
            borderRadius: "10px",
            boxShadow: "0 4px 8px rgba(0,0,0,0.2)",
          }}
          alt="Office Space"
        />
      </div>

      <div
        style={{
          display: "flex",
          justifyContent: "center",
          gap: "20px",
          flexWrap: "wrap",
        }}
      >
        {officeList.map((office, index) => (
          <div
            key={index}
            style={{
              backgroundColor: "#fff",
              padding: "15px",
              borderRadius: "12px",
              boxShadow: "0 4px 10px rgba(0,0,0,0.1)",
              width: "250px",
              textAlign: "center",
            }}
          >
            <h2 style={{ marginBottom: "8px", color: "#34495e" }}>
              {office.Name}
            </h2>
            <h3 style={{ color: office.Rent <= 60000 ? "#e74c3c" : "#27ae60" }}>
              Rent: Rs. {office.Rent}
            </h3>
            <h3 style={{ color: "#7f8c8d" }}>{office.Address}</h3>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
