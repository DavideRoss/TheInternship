using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DossierController : MonoBehaviour
{
    private PlayerController _player;

    public string Zone = "";
    public bool IsRequested;

    public IconController Icon;

    void Update()
    {
        if (IsRequested && _player && Input.GetButton("Fire1"))
        {
            _player.Grab(gameObject);
        }
    }

    private void OnTriggerEnter(Collider other) {
        if (!IsRequested) return;
        _player = other.GetComponent<PlayerController>();
        if (!_player) return;

        Icon.SetIcon("Dossier");
        Icon.SetActive(true);
    }

    private void OnTriggerExit(Collider other) {
        if (!IsRequested) return;
        _player = null;
        Icon.SetActive(false);
    }

    public void SetRequested() {
        IsRequested = true;
        GetComponent<MeshRenderer>().material.color = Color.magenta;
    }
}
