#include "dlt_types.h"

void Dlt_SendLog(uint8_t counter, const char* payload, uint16_t len) {
    Dlt_MsgHeader header;
    header.header_info = DLT_WEID_BIT | DLT_WTMS_BIT; // Use ECU ID and Timestamp
    header.msg_counter = counter;
    header.length = sizeof(Dlt_MsgHeader) + len;
    
    // In a real system, you would now send this 'header' 
    // followed by the 'payload' over the UART/Serial port.
}