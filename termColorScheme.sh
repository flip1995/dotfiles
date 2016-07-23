#!/usr/bin/env bash
# Base16 - Gnome Terminal color scheme install script
# Chris Kempson (http://chriskempson.com)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Pop"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-pop"
[[ -z "$DCONF" ]] && DCONF=dconf
[[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

dset() {
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    "$DCONF" write "$PROFILE_KEY/$key" "$val"
}

# because dconf still doesn't have "append"
dlist_append() {
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
            echo "'$val'"
        } | head -c-1 | tr "\n" ,
    )"

    "$DCONF" write "$key" "[$entries]"
}

# Newest versions of gnome-terminal use dconf
if which "$DCONF" > /dev/null 2>&1; then
    [[ -z "$BASE_KEY_NEW" ]] && BASE_KEY_NEW=/org/gnome/terminal/legacy/profiles:

    if [[ -n "`$DCONF list $BASE_KEY_NEW/`" ]]; then
        if which "$UUIDGEN" > /dev/null 2>&1; then
            PROFILE_SLUG=`uuidgen`
        fi

        if [[ -n "`$DCONF read $BASE_KEY_NEW/default`" ]]; then
            DEFAULT_SLUG=`$DCONF read $BASE_KEY_NEW/default | tr -d \'`
        else
            DEFAULT_SLUG=`$DCONF list $BASE_KEY_NEW/ | grep '^:' | head -n1 | tr -d :/`
        fi

        DEFAULT_KEY="$BASE_KEY_NEW/:$DEFAULT_SLUG"
        PROFILE_KEY="$BASE_KEY_NEW/:$PROFILE_SLUG"

        # copy existing settings from default profile
        $DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

        # add new copy to list of profiles
        dlist_append $BASE_KEY_NEW/list "$PROFILE_SLUG"

        # update profile values with theme options
        dset visible-name "'$PROFILE_NAME'"
        dset palette "['rgb(16,48,64)', 'rgb(231,76,60)', 'rgb(26,102,34)', 'rgb(241,196,15)', 'rgb(52,152,219)', 'rgb(155,89,182)', 'rgb(26,188,156)', 'rgb(224,224,224)', 'rgb(149,165,166)', 'rgb(231,76,60)', 'rgb(46,204,113)', 'rgb(241,196,15)', 'rgb(52,152,219)', 'rgb(155,89,182)', 'rgb(26,188,156)', 'rgb(236,240,241)']"
        dset background-color "'rgb(16,48,64)'"
        dset foreground-color "'#e0e0e0'"
        dset bold-color "'#e0e0e0'"
        dset bold-color-same-as-fg "true"
        dset use-theme-colors "false"
        dset use-theme-background "false"

        unset PROFILE_NAME
        unset PROFILE_SLUG
        unset DCONF
        unset UUIDGEN
        exit 0
    fi
fi

# For older gnome versions without dconf.

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Pop"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-pop"
[[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
[[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

gset() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local type="$1"; shift
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "$val"
    } | head -c-1 | tr "\n" ,
  )"

  "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append string /apps/gnome-terminal/global/profile_list "$PROFILE_SLUG"

gset string visible_name "$PROFILE_NAME"
gset string palette "#100030004000:#e7004c003c00:#1a0066002200:#f100c400f00:#34009800db00:#9b005900b600:#1a00bc009c00:#e000e000e000:#9500a500a600:#e7004c003c00:#2e00cc007100:#f100c400f00:#34009800db00:#9b005900b600:#1a00bc009c00:#ec00f000f100"
gset string background_color "#100030004000"
gset string foreground_color "#e000e000e000"
gset string bold_color "#e000e000e000"
gset bool   bold_color_same_as_fg "true"
gset bool   use_theme_colors "false"
gset bool   use_theme_background "false"

unset PROFILE_NAME
unset PROFILE_SLUG
unset GCONFTOOL
unset BASE_KEY
exit 0
