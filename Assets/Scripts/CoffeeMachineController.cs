using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoffeeMachineController : MonoBehaviour
{
    public float Cooldown = 3f;
    public IconController Icon;

    private PlayerController _player;
    private bool _active = true;

    private void Update() {
        if (_active && _player && Input.GetButtonDown("Fire1"))
        {
            _player.RefillCoffee(.3f);
            _active = false;
            GetComponent<MeshRenderer>().material.color = Color.black;
            StartCoroutine(StopCooldown());
        }
    }

    private void OnTriggerEnter(Collider other) {
        _player = other.GetComponent<PlayerController>();
        if (!_player) return;
        Icon.SetIcon("CoffeeMachine");
        Icon.SetActive(true);
    }

    private void OnTriggerExit(Collider other) {
        Icon.SetActive(false);
        _player = null;
    }

    private IEnumerator StopCooldown() {
        yield return new WaitForSeconds(Cooldown);
        GetComponent<MeshRenderer>().material.color = Color.red;
        _active = true;
    }
}
