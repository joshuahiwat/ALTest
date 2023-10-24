## [MD] Introduction

### **Background**
The task at hand is to develop a program in AL (Application Language) that enables employees to report their absences. This program should also have the capability to identify overlapping absence periods. This document outlines the data management architecture that has been designed for the implementation of this task.
### **Purpose**
The purpose of this architecture is to provide a structured and efficient way to manage absence data, enabling the program to handle absence reporting and overlap detection effectively.
### **Scope**
This architecture document covers the design and rationale behind the data management structure, including the database schema, interfaces, and other key components. It also explains why certain design decisions were made and what benefits they offer.

## System Architecture

### **Components**
The data management architecture consists of the following components:

1. **Database Tables:** Three tables for absence, absence lines, and registration.
1. **Enums:** Definitions for absence reasons and absence status.
1. **Interface:** A contract for creating absences with their lines and registering timestamps.
1. **Unit Tests:** Testing framework to ensure the correctness of absence creation and registration.
1. **ULID Generator:** A separate object(codeunit) for generating ULIDs.
### **Data Flow**
Data flows through the system in the following way:

1. Employees report their absences through the program.
1. The program creates absence records and registers timestamps in the database.
1. The program checks for absence period overlaps.

## Data Model
###
### **Database Tables**
The data model comprises three primary database tables:

1. **Absence:** Contains information about absences such as absence ULID, employee, reason, and status.
1. **Absence Lines:** Stores detailed information about absence periods, linked to the absence record.
1. **Registration:** A table for registering timestamps associated with absence events.
### **Enums**
Two enums have been defined:

1. **Absence Reasons:** Provides predefined reasons for employee absences.
1. **Absence Status:** Defines the status of absence events (e.g., pending, approved, denied).
### **Data Separation**
To maintain a clear distinction between data and structure, the absence data is separated into two tables: "Absence" and "Absence Lines." This separation enhances the organization and allows for more effective data management.

## Key Components
###
### **Interface**
An interface has been implemented as a contract for creating absence records along with their lines and registering timestamps. This promotes consistency and modularity in the code.
### **Unit Tests**
Unit tests have been developed to ensure the correctness of absence creation and registration processes. This ensures that the program functions as expected and helps identify and rectify issues early in the development cycle.
### **ULID Generator**
Instead of using UUIDv4, ULID (Universally Unique Lexicographically Sortable Identifier) has been chosen for generating unique IDs. ULIDs are more space-efficient, reducing the storage overhead and enhancing performance.

## Design Architecture
###
### **System Overview**
The design architecture for the absence reporting and overlap detection system is divided into multiple layers, each responsible for specific functions. These layers work in harmony to achieve the system's goals.
### **Explanation:**
- **Presentation Layer:** This layer handles user interactions. It's responsible for receiving absence reports from employees and presenting absence information to users.
- **Application Layer:** This layer acts as an intermediary between the presentation and data layers. It processes the user's requests and coordinates data retrieval and storage.
- **Data Layer:** The data layer contains the database tables (Absence, Absence Lines, and Registration). It stores and manages absence records, absence lines, and timestamps.
### **Data Model**
To provide a more detailed view of the data structure within the data layer.
### **Explanation:**
- **Absence Table:** This table contains information about each absence event, such as absence ID, employee ID, absence reason, and absence status.
- **Absence Lines Table:** This table is linked to the absence table and stores details about absence periods, including start and end times.
- **Registration Table:** The registration table registers timestamps associated with absence events. It is designed to be versatile and can be used for various timestamp registration needs.
### **Interaction**
The interaction between different components.
### **Explanation:**
1. An employee initiates an absence report through the presentation layer.
1. The application layer processes the report, validates the data, and creates absence records and absence lines.
1. The absence data is stored in the data layer (Absence and Absence Lines tables), while registration information is recorded in the Registration table.
1. The system checks for overlapping absence periods by querying the data.

### **Benefits**
The design architecture outlined above offers several key benefits:

- **Modularity:** The separation of layers promotes modularity, making it easier to maintain and extend the system.
- **Efficiency:** The data separation design improves data access efficiency, and the use of ULIDs reduces storage overhead.
- **Reusability:** The Registration table can be reused for timestamp registration in other parts of the system, enhancing system flexibility and scalability.
