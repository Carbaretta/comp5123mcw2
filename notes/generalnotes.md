# AMF - access and mobility management function

The AMF performs as a type of "Reception desk" when devices connect ("logging on"). Tracks phone movement between cell towers. Will be the best component to use for metric tracking

# User Plan Function

Packet router. Bit that actually handles movement of data when you make web requests.

# Control Plane

Acts as the brain.

Consists of AMF and SMF.

SG (Session management function) tells User plane how to route a specific user's data. Works like a traffic cop.

# Security and databases

UDM - UNified Data Management is the master user list, containing profile and services you're allowed to use.

UDR - Unified data repository is the actual hard drive and database where UDM stores said user info.

AUSF - Authentication server function works with the UDM to erify a SIM card is legitimate, not a clone.

# Management and logistis

NRF - NF repository function. Acts like a directory. When the AMF needs to find the SMF, it finds it in teh NRF.

SCP - Service communication proxy. Works as a switchboard helping all different functions to communicate without needing to know everyon'es direct ip address.

PCF POlicy and charginf functin decides quality of service. Does things like giving 5g ambulances priority over someone watching TikToks

NSSF Network SLice selection function allocates users to specific sections of vrtual networks.

BSF Binding SUpport Function is a record keeper ensuring that the same policy function remains vound to the same user so rules don't change midstream.

AMF CPU will spike when many users log in at once. UPF RAM and CPU will spik when the users download large files.
