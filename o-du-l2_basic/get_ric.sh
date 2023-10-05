
RIC_HOST=$RIC_HOST
if [ -z "${RIC_HOST}" ]; then
    echo "RIC_HOST is not set, please set it before running the script."
    exit 1
fi
echo "RIC_IP: $RIC_HOST"

export E2_SCTP_PORT=36422
export DU_IP_V4_ADDR="10.6.1.2"
export CU_IP_V4_ADDR="10.6.1.3"
DESTINATION_DU_IPV4_ADDR="10.6.1.4"


# setup RIC e2term address and port
sed -i "s/^#define RIC_IP_V4_ADDR.*/#define RIC_IP_V4_ADDR \"${RIC_HOST}\"/g" ./src/du_app/du_cfg.h
sed -i "s/^#define E2_SCTP_PORT.*/#define E2_SCTP_PORT ${E2_SCTP_PORT}/g" ./src/du_app/du_cfg.h
#sed -i "s/^#define RIC_PORT.*/#define RIC_PORT ${RIC_PORT}/g" ./src/du_app/du_cfg.h

# setup DU address
sed -i "s/^#define DU_IP_V4_ADDR.*/#define DU_IP_V4_ADDR \"${DU_IP_V4_ADDR}\"/g" ./src/du_app/du_cfg.h
sed -i "s/^#define DU_IP_V4_ADDR.*/#define DU_IP_V4_ADDR (char*[]){\"${DU_IP_V4_ADDR}\", \"${DESTINATION_DU_IPV4_ADDR}\"} /g" ./src/cu_stub/cu_stub.h
sed -i "s/^#define SOURCE_DU_IPV4_ADDR.*/#define SOURCE_DU_IPV4_ADDR \"${DU_IP_V4_ADDR}\"/g" ./src/phy_stub/phy_stub.h
sed -i "s/^#define DESTINATION_DU_IPV4_ADDR.*/#define DESTINATION_DU_IPV4_ADDR \"${DESTINATION_DU_IPV4_ADDR}\"/g" ./src/phy_stub/phy_stub.h

# setup CU address
sed -i "s/^#define CU_IP_V4_ADDR.*/#define CU_IP_V4_ADDR \"${CU_IP_V4_ADDR}\"/g" ./src/du_app/du_cfg.h
sed -i "s/^#define CU_IP_V4_ADDR.*/#define CU_IP_V4_ADDR \"${CU_IP_V4_ADDR}\"/g" ./src/cu_stub/cu_stub.h


