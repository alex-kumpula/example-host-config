# --- START OF SCRIPT ---
#
# NOTE: Nix expressions (${...}) are NOT used in this file.
# Variables are passed to this script by Nix.


# Log a starting message to the kernel message buffer (kmsg), visible via dmesg.
echo "btrfs-rollback-on-boot: Rolling back $SV_WIPE_NAME..." >/dev/kmsg

# --- Mount Btrfs Volumes ---

mkdir $SV_WIPE_DEVICE_TEMP_MOUNT_POINT
mount $SV_WIPE_DEVICE $SV_WIPE_DEVICE_TEMP_MOUNT_POINT
SV_WIPE_PATH="$SV_WIPE_DEVICE_TEMP_MOUNT_POINT$SV_WIPE_PATH_ON_DEVICE"

mkdir $SV_PERSIST_DEVICE_TEMP_MOUNT_POINT
mount $SV_PERSIST_DEVICE $SV_PERSIST_DEVICE_TEMP_MOUNT_POINT
SV_PERSIST_PATH="$SV_PERSIST_DEVICE_TEMP_MOUNT_POINT$SV_PERSIST_PATH_ON_DEVICE"

SNAPSHOTS_DIR="$SV_PERSIST_PATH$SNAPSHOT_PATH_IN_SV_PERSIST"

# --- Previous Subvolume Backup (The "Explosion") ---

if [[ -e $SV_WIPE_PATH ]]; then

    mkdir -p $SNAPSHOTS_DIR

    timestamp=$(date --date="@$(stat -c %Y $SV_WIPE_PATH)" "+%Y-%m-%d_%H:%M:%S")
    SNAPSHOT_PATH="$SNAPSHOTS_DIR/$timestamp"
    
    if [[ ! -e $SNAPSHOT_PATH ]]; then
    
        mv $SV_WIPE_PATH $SNAPSHOT_PATH

    else
    
        btrfs subvolume delete $SV_WIPE_PATH
    fi
fi

# --- Create new subvolume and unmount ---

btrfs subvolume create $SV_WIPE_PATH

umount $SV_WIPE_DEVICE_TEMP_MOUNT_POINT
umount $SV_PERSIST_DEVICE_TEMP_MOUNT_POINT



# Log a successful completion message to the kernel message buffer.
echo "btrfs-rollback-on-boot: Done rolling back $SV_WIPE_NAME!" >/dev/kmsg

# --- END OF SCRIPT ---