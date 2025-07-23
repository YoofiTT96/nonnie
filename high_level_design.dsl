workspace "Name" "Description" {

    !identifiers hierarchical
    !impliedRelationships true

    model {
        operations = person "Operations Officer"
        developer = person "Software Engineer"
        finance = person "Finance Officer"
        clientHead = person "Head of Clients"
        projectLead = person "Project Lead"

        externalOAuth2ResourceServer = softwareSystem "Office 365" "Holds information on active employees"

        salesApplication = softwareSystem "External Sales Management Application" "External Application for tracking the progress of sales"

        nonnie = softwareSystem "Nonnie" {
            fe = container "Front end application""Interface for interacting with Nonnie" "HTML,Cnonnie,Javascript" {
                templatingService = component "Template Service""Responsible for the creation and editing of templates with placeholders"
            }
            ws = container "Web Service" "Web service powering Nonnie" "Python/Java Spring boot" {
                authenticationService = component "Authentication Service" "Manages login access for users. Also provides fallback services for the creation of users"
                contractService = component "Contract Service" "Manages contracts and deals"
                authorizationService = component "Authorization Service" "Responsible for determining if a user has perminonnieion to perform an action. Also retrieve roles for a user"
                projectService = component "Project Service" "Manages project creation, assignment of team members and deliverables"
                billingService = component "Billing Service"
                notificationService = component "Notification Service"
                workflowService = component "Workflow Service" "Manages the creation of workflows such as onboarding and offboarding workflows"
            }
            db = container "Database""RDBMS for storing data" "PostgresSQL" {
                tags "Database"
            }
        }

        nonnie -> externalOAuth2ResourceServer "OAuth/2 Login. Used to derive user information"

        salesApplication -> nonnie "Sends information on completed deals"

        operations -> nonnie "Sets up contracts and gets data for reporting"
        developer -> nonnie "Inputs work details such as time worked"
        nonnie -> finance "Notifies for the raising of bills/invoices"
        nonnie -> clientHead "Notifies for the selection of project lead"
        clientHead -> nonnie "Approves contracts and chooses project lead"
        projectLead -> nonnie "Sets up project details such as deliverables/milestones and team members"
        nonnie -> projectLead "Notifies about projects created needing details"

        nonnie.fe -> nonnie.ws "Makes queries to"
        nonnie.ws -> nonnie.db "Reads from/Writes to"

        nonnie.ws.billingService -> nonnie.ws.notificationService "Sends info for raising bills"
        nonnie.ws.billingService -> nonnie.ws.contractService "Obtains information on contracting and deals for calculating bills"
        nonnie.ws.billingService -> nonnie.ws.projectService "Obtains information about projects including team members and time sheets submitted"
        nonnie.ws.projectService -> nonnie.ws.contractService "Obtains information for creating projects after contracts are signed"
        nonnie.ws.contractService -> nonnie.ws.notificationService "Send information about contracting"
        nonnie.ws.projectService -> nonnie.ws.notificationService "Send information about project set up and creation"
    }

    views {
        systemContext nonnie "Diagram1" {
            include *
            autolayout lr
        }

        container nonnie "Diagram2" {
            include *
            autolayout lr
        }

        component nonnie.fe "FE_Component_Diagram" {
            include *
            autoLayout lr
        }

         component nonnie.ws "WS_Component_Diagram" {
            include *
            autoLayout lr
        }


        styles {
            element "Element" {
                color #ffffff
            }
            element "Person" {
                background #199b65
                shape person
            }
            element "Software System" {
                background #1eba79
            }
            element "Container" {
                background #23d98d
            }
            element "Database" {
                shape cylinder
            }
            element "Component" {
                background #04975A
            }
        }
    }

    configuration {
        scope softwaresystem
    }

}