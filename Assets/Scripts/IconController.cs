using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[Serializable]
public struct IconDef {
    public string Name;
    public Texture IconTexture;
}

public class IconController : MonoBehaviour
{
    public IconDef[] Icons;

    private void Start() {
        gameObject.SetActive(false);
    }

    public void SetIcon(string iconName) {
        IconDef sel = Icons.SingleOrDefault(id => id.Name == iconName);
        GetComponent<MeshRenderer>().material.mainTexture = sel.IconTexture;
    }

    public void ToggleIcon() {
        gameObject.SetActive(!gameObject.activeInHierarchy);
    }

    public void SetActive(bool act) {
        gameObject.SetActive(act);
    }
}
