#ifndef DLT_TYPES_H
#define DLT_TYPES_H

#include "tpl_os_std_types.h"

// AUTOSAR DLT Standard Header bits
#define DLT_UEH_BIT 0x01 // Use Extended Header
#define DLT_MSBF_BIT 0x02 // MSB First
#define DLT_WEID_BIT 0x04 // With ECU ID
#define DLT_WSID_BIT 0x08 // With Session ID
#define DLT_WTMS_BIT 0x10 // With Timestamp

typedef struct {
    uint8_t  header_info;
    uint8_t  msg_counter;
    uint16_t length;
    char     ecu_id[4];
} Dlt_MsgHeader;

#endif